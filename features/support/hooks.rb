Before '@github-web' do
  @use_github_website = true
  Capybara.current_driver = Capybara.javascript_driver
end

Before '~@github-web' do
  OmniAuth.config.test_mode = true
end
