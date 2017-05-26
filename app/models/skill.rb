class Skill < ApplicationRecord
  has_many :employee_skills, dependent: :destroy

  validates :name, presence: true
end
