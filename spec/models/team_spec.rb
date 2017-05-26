require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'initialize' do
    it { is_expected.to have_many(:employees).dependent(:destroy) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:mission) }
    it { is_expected.to respond_to(:vision) }
    it { is_expected.to respond_to(:name) }
  end
end
