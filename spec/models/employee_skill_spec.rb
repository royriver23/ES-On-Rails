require 'rails_helper'

RSpec.describe EmployeeSkill, type: :model do

  describe 'initialize' do
    it { is_expected.to belong_to(:employee) }
    it { is_expected.to belong_to(:skill) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:skill) }
    it { is_expected.to respond_to(:employee) }
  end
end
