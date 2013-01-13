class Octopub
  attr_reader :github

  def initialize(token)
    @github = Github.new oauth_token: token
  end

  def create_repo(name)
    github.repos.create name: name, auto_init: true
  end

  def get_repo(name)
    github.repos.get(login, name)
  end

  def list_repos
    github.repos.list
  end

  def create_blog(name)
    repo = name.downcase.gsub(/\s/, '-')
    create_repo(repo)
  end

  private

  def login
    @login ||= github.users.get['login']
  end
end
