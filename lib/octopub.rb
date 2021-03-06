require './lib/octopub/blog'
require './lib/octopub/octopress_cloner'
require './lib/octopub/tree_builder'

module Octopub
  def self.new(token)
    Client.new(token)
  end

  class Client
    attr_reader :github

    def initialize(token)
      @github = Github.new oauth_token: token
    end

    def create_blog(name)
      repo = name.downcase.gsub(/\s/, '-')
      create_repo repo
      Octopub::Blog.new login, repo, @github
    end

    private

    def commit_to_master(tree, message='Octopub autogenerated commit.')
      tree = @github.git_data.trees.create(login, repo_name(name), tree)

      @github.git_data.commits.create(login, repo_name(name),
                                      message: 'Duplicate octopress repo',
                                      tree: tree['sha'],
                                      parents: ['master'])
    end

    def create_repo(name)
      github.repos.create name: name, auto_init: true
    end

    def login
      @login ||= github.users.get['login']
    end
  end
end
