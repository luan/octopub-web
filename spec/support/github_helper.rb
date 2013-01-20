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
    oauth = github.oauth.all.select do |oa|
      oa['app']['name'] == 'Octopub TEST'
    end.first

    github.oauth.delete oauth['id'] rescue nil

    github.oauth.create({
      client_id: Secrets[:GITHUB_KEY],
      client_secret: Secrets[:GITHUB_SECRET],
      scopes: 'public_repo'
    })['token']
  end
end

