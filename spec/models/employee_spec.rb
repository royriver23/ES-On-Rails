require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'initialize' do
    it { is_expected.to have_many(:employee_skills).dependent(:destroy) }
    it { is_expected.to have_many(:skills) }
    it { is_expected.to belong_to(:team) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:birthday) }
    it { is_expected.to respond_to(:identification) }
    it { is_expected.to respond_to(:active) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:team) }
  end
end
