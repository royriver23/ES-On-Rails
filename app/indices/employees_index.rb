class EmployeesIndex < ApplicationIndex
    settings analysis: {
      analyzer: {
        user_data: {
          tokenizer: :standard,
          filter: %i(lowercase edge_ngram_2x10)
        }
      },

      filter: {
        edge_ngram_2x10: {
          type: :edgeNGram,
          min_gram: 2,
          max_gram: 10
        }
      }
    }

  # Do not use it as serializer alternative
  define_type Employee.includes(:team, :skills) do
    field :id
    field :team_id, index: 'not_analyzed'
    field :first_name, index: 'not_analyzed'
    field :last_name, index: 'not_analyzed'
    field :description, index: 'not_analyzed'
    field :team_name, value: -> { team.name }
    field :team_mission, value: -> { team.mission }
    field :team_vision, value: -> { team.vision }
    field :employee_skills, value: -> { skills.pluck(:name) }
    field :active, index: 'not_analyzed'
    field :search_data, value: ->(emp) {
      [emp.first_name, emp.last_name, emp.team.name, emp.team.mission,
       emp.team.vision, emp.skills.pluck(:name)].flatten.compact
    }, analyzer: :user_data
  end

  class << self
    def searcher
      EmployeeSearcher.new
    end
  end
end
