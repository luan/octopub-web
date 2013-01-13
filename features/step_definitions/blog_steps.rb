When /^I create a blog named "(.*?)"$/ do |blog_name|
  click_on 'Create Blog'

  within 'form' do
    fill_in 'Blog Name', with: blog_name
    click_on 'Create'
  end
end

