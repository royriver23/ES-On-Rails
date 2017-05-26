class Employee < ApplicationRecord
  belongs_to :team
  has_many :employee_skills, dependent: :destroy
  has_many :skills, through: :employee_skills

  validates :first_name, presence: true
  validates :last_name, presence: true
end
