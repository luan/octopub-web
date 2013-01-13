require 'spec_helper'

describe Blog do
  describe "security" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :repo }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :repo }
    it { should validate_uniqueness_of(:repo).scoped_to(:user_id) }
  end

  describe 'relations' do
    it { should belong_to :user }
  end
end
