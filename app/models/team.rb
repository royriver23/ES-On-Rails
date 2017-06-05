class Team < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: true

  SEARCH_FIELDS = %i(name).freeze
end
