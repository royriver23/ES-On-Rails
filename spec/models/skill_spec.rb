require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'initialize' do
    it { is_expected.to have_many(:employee_skills).dependent(:destroy) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
  end
end
