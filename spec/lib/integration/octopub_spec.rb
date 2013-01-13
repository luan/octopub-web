require 'active_support/all'
require 'github_api'

unless defined? Rails
  module Rails
    def self.root ; '.' ; end
    def self.env ; 'test' ; end
  end
end

require './spec/support/github_helper'
require './lib/octopub'

def check_deleted(github, repo_name)
  tries = 0
  while (github.repos.get(Secrets[:GITHUB_USER], name) rescue nil)
    tries += 1
    raise 'Could not delete repostory' if tries >= 10
    sleep 0.25
  end
end

describe "Octopub integration" do
  before :all do
    WebMock.allow_net_connect! if defined? WebMock
    @token = GithubHelper.github_token
    @octopub = Octopub.new @token
    @octopub.create_repo 'a-blog' rescue nil
  end

  after :all do
    @github.repos.delete Secrets[:GITHUB_USER], 'a-blog' rescue nil
    check_deleted @github, 'a-blog'
    WebMock.disable_net_connect! if defined? WebMock
  end

  describe "#get_repo" do
    it "returns the repo created" do
      @octopub.get_repo('a-blog')['name'].should == 'a-blog'
    end
  end

  describe "#list_repos" do
    it "returns the repo created" do
      @octopub.list_repos.should have_repo 'a-blog'
    end
  end
end

