module Searchable
  extend ActiveSupport::Concern

  included do
    before_action :verify_search_params
  end

  private

  def verify_search_params
    if search_param && search_param.size < 3
      json_response({ message: 'Search query must be longer than 2 characters.' }, :bad_request)
    end
  end

  def search_param
    params[:q].present? ? params[:q].to_s : nil
  end

  # Basic scenario, single model source
  def search(active_record_relation)
    fields = Array(active_record_relation.model::SEARCH_FIELDS) if defined?(active_record_relation.model::SEARCH_FIELDS)
    if fields.present? && search_param
      where_string = fields.map { |field| "#{field} ilike ?" }.join(' OR ')
      active_record_relation.where(where_string, *fields.map { "%#{search_param}%" })
    else
      active_record_relation
    end
  end
end
