class ApplicationSearcher
  class Results
    extend Forwardable

    attr_reader :rows

    def initialize rows, total_count
      @rows = rows.freeze
      @total_count = total_count
    end

    def count
      @total_count
    end

    def_delegators :@rows, :each, :map, :as_json
  end
end
