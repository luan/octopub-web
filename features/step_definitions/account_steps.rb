Given /^I have never logged in$/ do
  step "I revoke the app key on the github website" if @use_github_website
end

Given /^I have authorized the octopub app$/ do
  step "I have a github account"
  step "I generate a token for the octopub app" unless @use_github_website
  step "I try to login"
  step "I allow the app to do actions on my behalf on the website" if @use_github_website
end

When /^I try to login$/ do
  visit '/'
  click_on 'Sign in through GitHub'
end

When /^I allow the app to do actions on my behalf$/ do
  step "I allow the app to do actions on my behalf on the website" if @use_github_website
end

Then /^I should be registered$/ do
  User.count.should == 1
  @user = User.last
  @user.username.should == Secrets[:GITHUB_USER]
end

Then /^I should be logged in/ do
  page.should have_content Secrets[:GITHUB_USER]
  @user.token.should_not be_blank
end

Given /^I have an octopub account$/ do
  step "I have authorized the octopub app"
  @user = User.find_or_create_by_username(Secrets[:GITHUB_USER])
end
