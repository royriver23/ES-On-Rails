class Employee < ApplicationRecord
  update_index('employees#employee') { self }

  belongs_to :team
  has_many :employee_skills, dependent: :destroy
  has_many :skills, through: :employee_skills

  validates :first_name, presence: true
  validates :last_name, presence: true

  SEARCH_FIELDS = %i(first_name last_name description).freeze
end
