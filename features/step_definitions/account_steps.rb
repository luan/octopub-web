Given /^I have a github account$/ do
  if @use_github_website
    step "I login to the github website"
  end
end

Given /^I have never logged in$/ do
  if @use_github_website
    step "I revoke the app key on the github website"
  end
end

When /^I try to login$/ do
  visit '/'
  click_on 'Sign in through GitHub'
end

When /^I allow the app the do actions on my behalf$/ do
  if @use_github_website
    click_on 'Authorize app'
    current_path.should == '/'
  end
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
  step "I have a github account"
  @user = User.find_or_create_by_username(Secrets[:GITHUB_USER])
end
