require './config/initializers/secrets'

class GithubHelper
  def self.github_login
    Github.new({
      login: Secrets[:GITHUB_USER],
      password: Secrets[:GITHUB_PASSWD]
    })
  end

  def self.github_token(github=nil)
    github ||= github_login
    oauth = github.oauth.all.select { |oa| oa['app']['name'] == 'Octopub TEST' }.first
    github.oauth.delete oauth['id']

    github.oauth.create({
      client_id: Secrets[:GITHUB_KEY],
      client_secret: Secrets[:GITHUB_SECRET]
    })['token']
  end
end

RSpec::Matchers.define :have_repo do |repo_name|
  match do |actual|
    repos = actual.respond_to?(:repos) ? actual.repos.list : actual
    repos.select { |r| r['name'] == repo_name }.first != nil
  end

  failure_message_for_should do |actual|
    "expected user to have #{expected} repository"
  end

  failure_message_for_should_not do |actual|
    "expected user not to have #{expected} repository"
  end

  description do
    "have a repository called #{expected}"
  end
end
