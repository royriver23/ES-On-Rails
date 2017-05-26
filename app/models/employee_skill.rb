class EmployeeSkill < ApplicationRecord
  belongs_to :employee
  belongs_to :skill
  has_many :employee_skills
  has_many :skills, throught: :employee_skills
end
