Given /^I have a github account$/ do
  visit 'https://github.com/login'
  fill_in 'Username or Email', with: ENV['GITHUB_USER']
  fill_in 'Password', with: ENV['GITHUB_PASSWD']
  click_button 'Sign in'
end

Given /^I have never logged in$/ do
  visit 'https://github.com/settings/applications'
  settings = find '#page-settings .settings-content'
  authorized = settings.find('h3', text: 'Authorized applications').find(:xpath, '..')

  begin
    app = authorized.find_link(text: 'Octopub TEST').find(:xpath, '..')
    app.click_on 'Revoke'
  rescue
  end
end

When /^I try to login$/ do
  visit '/'
  click_on 'Sign in through GitHub'
end

When /^I allow the app the do actions on my behalf$/ do
  click_on 'Allow'
  current_path.should == '/'
end

Then /^I should be registered$/ do
  User.count.should == 1
  @user = User.last
  @user.username.should == ENV['GITHUB_USER']
end

Then /^I should be logged in/ do
  page.should have_content ENV['GITHUB_USER']
end

Given /^I have an account$/ do
  @user = User.create_with_username ENV['GITHUB_USER']
end

