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
      @user.octopub.should be_a(Octopub::Client)
    end
  end

  describe "#create_blog" do
    before do
      @user = User.create! { |u| u.username = 'login' }
      @blog = stub(repo: 'repo-the-name').as_null_object
      @user.octopub.stub(:create_blog).and_return(@blog)
    end

    it "creates a blog" do
      @user.create_blog 'Repo The Name'
      @user.blogs.should have(1).blog
      @user.blogs.last.repo.should == 'repo-the-name'
    end

    it "clones octopress" do
      @blog.should_receive(:clone_octopress)
      @user.create_blog 'Repo The Name'
    end
  end
end
