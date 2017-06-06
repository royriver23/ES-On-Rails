require 'application_searcher/results'

class ApplicationSearcher
  class_attribute :_search_index
  def self.search_index index_klass
    self._search_index = index_klass
  end

  class_attribute :_sortable_fields
  def self.sortable_fields *fields
    self._sortable_fields = fields
  end

  class_attribute :_skip_pagination
  def self.skip_pagination option
    self._skip_pagination = option
  end

  class_attribute :_default_scope
  def self.default_scope &block
    self._default_scope = block
  end

  attr_reader :filters, :search_query, :sort_field, :sort_dir, :offset, :count

  def initialize apply_default_scope: true
    @index = self.class._search_index
    @count = 10
    @offset = 0
    @sort_field = nil
    @sort_dir = :asc

    @filters = []
    @search_query = nil

    @results = nil
    @queried = false

    @result_count = nil

    if self.class._default_scope && apply_default_scope
      initialize_default_scope
    end
  end

  def results
    unless @queried
      execute
      @queried = true
    end
    @results
  end

  def paginate count, offset
    dup do
      @count = count || @count
      @offset = offset || @offset
    end
  end

  def sort field, direction
    unless self.class._sortable_fields.include? field
      fail "#{self.class.name} unable to sort by #{field}"
    end

    dup do
      @sort_field = field
      @sort_dir = direction
    end
  end

  def fetch *ids
    filter do
      {
        terms: {
          _id: ids
        }
      }
    end
  end

  private

  def dup &block
    instance = self.class.new apply_default_scope: false
    instance.send :be_duped, from: self
    instance.instance_eval(&block)
    instance
  end

  def be_duped(from:)
    @filters.replace from.filters
    @search_query = from.search_query
    @sort_field = from.sort_field
    @sort_dir = from.sort_dir
    @offset = from.offset
    @count = from.count
  end

  def initialize_default_scope
    dup_with_defaults = instance_eval(&self.class._default_scope)
    be_duped from: dup_with_defaults
  end

  def filter
    dup do
      new_filters = yield

      if new_filters.is_a? Hash
        filters << new_filters
      elsif new_filters.is_a? Array
        new_filters.each do |filter|
          filters << filter
        end
      end

    end
  end

  def query
    dup do
      @search_query = yield
    end
  end

  def execute
    @query = @index.filter( bool: { must: @filters } ).query(@search_query)

    if @sort_field
      @query = @query.order @sort_field => @sort_dir
    end

    @query = if self.class._skip_pagination
      @query.limit(@query.total_count).offset(0)
    else
      @query.limit(@count).offset(@offset)
    end

    @rows = @query.to_a.map(&:attributes).freeze
    count = @query.total_count

    @results = Results.new @rows, count
  end
end
