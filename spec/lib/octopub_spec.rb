require './lib/octopub'

Github = Struct.new(:params) unless defined? Github

describe Octopub do
  let(:github) { subject.github }
  subject { Octopub.new(stub) }
  before { subject.stub(login: 'userbuser') }

  describe '#create_repo' do
    it "creates a repository" do
      github.stub(repos: stub)
      github.repos.should_receive(:create).with(name: 'somerepo', auto_init: true)
      subject.create_repo 'somerepo'
    end
  end

  context "integrationee" do
    describe "#get_repo" do
      it "returns the repo created" do
        github.stub(repos: stub)
        github.repos.should_receive(:get).with('userbuser', 'a-blog')
        subject.get_repo('a-blog')
      end
    end

    describe "#list_repos" do
      it "returns the repo created" do
        github.stub_chain(:repos, list: [stub])
        subject.list_repos.should have(1).repo
      end
    end

    describe "#create_blog" do
      it "creates a repository" do
        subject.should_receive(:create_repo).with('a-blog')
        subject.create_blog 'A Blog'
      end
    end
  end
end

