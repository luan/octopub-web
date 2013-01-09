Given /^I login to the github website$/ do
  visit 'https://github.com/login'
  fill_in 'Username or Email', with: Secrets[:GITHUB_USER]
  fill_in 'Password', with: Secrets[:GITHUB_PASSWD]
  click_button 'Sign in'
end

Given /^I revoke the app key on the github website$/ do
  visit 'https://github.com/settings/applications'
  settings = find '#page-settings .settings-content'
  authorized = settings.find('h3', text: 'Authorized applications').find(:xpath, '..')

  begin
    app = authorized.find_link(text: 'Octopub TEST').find(:xpath, '..')
    app.click_on 'Revoke'
  rescue
  end
end
