module OmniAuth
  def self.mock_github_auth(token='', username=Secrets[:GITHUB_USER])
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      credentials: {
        token: token
      },
      extra: {
        raw_info: {
          login: username
        }
      }
    })
  end
end
