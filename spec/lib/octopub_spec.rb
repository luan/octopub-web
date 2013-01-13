require './lib/octopub'

Github = Struct.new(:params) unless defined? Github

describe Octopub do
  before do
    @octopub = Octopub.new 'token'
    @github = @octopub.github
    @octopub.stub(login: 'userbuser')
  end

  describe '#create_repo' do
    it "creates a repository" do
      @github.stub(repos: stub)
      @github.repos.should_receive(:create).with(name: 'somerepo', auto_init: true)
      @octopub.create_repo 'somerepo'
    end
  end

  describe "#get_repo" do
    it "returns the repo created" do
      @github.stub(repos: stub)
      @github.repos.should_receive(:get).with('userbuser', 'a-blog')
      @octopub.get_repo('a-blog')
    end
  end

  describe "#list_repos" do
    it "returns the repo created" do
      @github.stub_chain(:repos, list: [stub])
      @octopub.list_repos.should have(1).repo
    end
  end

  describe "#create_blog" do
    it "creates a repository" do
      @octopub.should_receive(:create_repo).with('a-blog')
      @octopub.create_blog 'A Blog'
    end
  end
end

