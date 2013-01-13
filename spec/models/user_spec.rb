require 'spec_helper'

describe User do
  describe "security" do
    it { should_not allow_mass_assignment_of :username }
    it { should_not allow_mass_assignment_of :token }
  end

  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :token }
  end

  describe "relations" do
    it { should have_many :blogs }
  end

  before { @user = User.new }

  describe "#octopub" do
    it "builds an Octopub client object" do
      @user.octopub.should be_a(Octopub)
    end
  end

  describe "#create_blog" do
    before do
      @user = User.create! { |u| u.username = 'login' }
      @user.octopub.stub(:create_repo)
    end

    it "creates a github repo" do
      @user.octopub.should_receive(:create_repo).with('repo-the-name')
      @user.create_blog 'Repo The Name'
    end

    it "creates a blog" do
      @user.create_blog 'Repo The Name'
      @user.blogs.should have(1).blog
    end
  end
end
