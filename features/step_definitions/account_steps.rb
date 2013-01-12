Given /^I have a github account$/ do
  if @use_github_website
    step "I login to the github website"
  else
    @github = Github.new({
      login: Secrets[:GITHUB_USER],
      password: Secrets[:GITHUB_PASSWD]
    })
  end
end

Given /^I have never logged in$/ do
  if @use_github_website
    step "I revoke the app key on the github website"
  end
end

Given /^I have authorized the octopub app$/ do
  step "I have a github account"
  step "I try to login"
  step "I allow the app to do actions on my behalf"
end

When /^I try to login$/ do
  if @use_github_website
    visit '/'
    click_on 'Sign in through GitHub'
  end
end

When /^I allow the app to do actions on my behalf$/ do
  if @use_github_website
    click_on 'Authorize app'
    current_path.should == '/'
  else
    oauths = @github.ouath.all
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
  step "I have authorized the octopub app"
  @user = User.find_or_create_by_username(Secrets[:GITHUB_USER])
end
