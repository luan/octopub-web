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

  describe "#octopub" do
    it "builds an Octopub client object" do
      subject.octopub.should be_a(Octopub)
    end
  end

  describe "#create_blog" do
    subject { User.create! { |u| u.username = 'login' } }
    before { subject.octopub.stub(:create_repo) }

    it "creates a github repo" do
      subject.octopub.should_receive(:create_repo).with('repo-the-name')
      subject.create_blog 'Repo The Name'
    end

    it "creates a blog" do
      subject.create_blog 'Repo The Name'
      subject.blogs.should have(1).blog
    end
  end
end
