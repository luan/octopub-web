When /^I create a blog named "(.*?)"$/ do |blog_name|
  click_on 'Create Blog'

  within 'form' do
    fill_in 'Blog Name', with: blog_name
    click_on 'Create'
  end
end

Then /^I should have an octopress clone called "(.*?)"$/ do |repo_name|
  step %{I should have a github repo called "#{repo_name}"}
  @github.should have_file('README.markdown').in_repo(repo_name).with_content('What is Octopress?')
  @github.should_not have_file('README.md').in_repo(repo_name)
end
