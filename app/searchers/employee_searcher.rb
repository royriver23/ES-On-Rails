require 'application_searcher'

class EmployeeSearcher < ApplicationSearcher

  search_index EmployeesIndex
  sortable_fields :updated_at, :created_at
  skip_pagination true

  def get_ids(team_id:, search_text:)
    search = authorization_filter
    search = search.team_filter team_id: team_id
    search = search.text_search(search_text) if search_text.present?
    search.results.rows.map{ |row| row['id'] }
  end

  def team_filter team_id:
    filter do
      { term: { team_id: team_id }}
    end
  end

  def authorization_filter
    filter do
      [
        {
          bool: {
            must: { term: { active: true }}
          }
        }
      ]
    end
  end

  def text_search search_text
    query do
      { match: { 'search_data' => search_text }}
    end
  end
end
