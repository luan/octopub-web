require 'spec_helper'

describe User do
  describe "security" do
    it { should_not allow_mass_assignment_of(:username) }
    it { should_not allow_mass_assignment_of(:token) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:token) }
  end
end
