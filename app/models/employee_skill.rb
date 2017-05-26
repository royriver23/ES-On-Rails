class EmployeeSkill < ApplicationRecord
  belongs_to :employee, required: true
  belongs_to :skill, required: true
end
