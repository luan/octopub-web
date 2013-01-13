Given /^I have a github account$/ do
  if @use_github_website
    step "I login to the github website"
  end
  @github = GithubHelper.github_login
end

Given /^I generate a token for the octopub app$/ do
  token = GithubHelper.github_token @github

  OmniAuth.mock_github_auth token
end

Given /^I have no repositories called "(.*?)"$/ do |repo_name|
  @github.repos.delete Secrets[:GITHUB_USER], repo_name rescue nil
  @github.should_not have_repo repo_name
end

Then /^I should have a github repo called "(.*?)"$/ do |repo_name|
  @github.should have_repo repo_name
end
