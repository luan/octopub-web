require_relative 'secrets'

OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Secrets[:GITHUB_KEY], Secrets[:GITHUB_SECRET], scope: "user,repo,gist"
end
