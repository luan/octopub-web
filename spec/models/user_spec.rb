require 'spec_helper'

describe User do
  describe "security" do
    it { should_not allow_mass_assignment_of(:username) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end

  describe "building a user with a username" do
    it "saves the user to the database" do
      User.create_with_username 'lombada'
      User.last.username.should == 'lombada'
    end
  end
end
