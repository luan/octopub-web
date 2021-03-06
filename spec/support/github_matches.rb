require './config/initializers/secrets'

RSpec::Matchers.define :have_repo do |repo_name|
  def has_repo?(repo_name, want)
    tries = 0
    result = !want

    until result == want || tries >= 5
      repos = actual.repos.list
      result = repos.select { |r| r['name'] == repo_name }.first != nil
      tries += 1
      sleep 0.5
    end

    result
  end

  match do |actual|
    has_repo?(repo_name, true)
  end

  match_for_should_not do |actual|
    !has_repo?(repo_name, false)
  end

  failure_message_for_should do |actual|
    "expected user to have #{expected} repository"
  end

  failure_message_for_should_not do |actual|
    "expected user not to have #{expected} repository"
  end

  description do
    "have a repository called #{expected}"
  end
end

RSpec::Matchers.define :have_file do |filename|
  chain :in_repo do |repo_name|
    @repo_name = repo_name
  end

  chain :with_content do |content|
    @content = content
  end

  match do |actual|
    raise 'Need a repo name (use .in_repo(repo_name))' unless @repo_name

    file_content = actual.repos.contents.
      get(Secrets[:GITHUB_USER], @repo_name, filename)['content'] rescue false

    if @content
      require 'base64'
      Base64.decode64(file_content).include?(@content)
    else
      file_content
    end
  end

  failure_message_for_should do |actual|
    if @content
      "expected #{@repo_name} to have #{expected} file with content #{@content}"
    else
      "expected #{@repo_name} to have #{expected} file"
    end
  end

  failure_message_for_should_not do |actual|
    "expected #{@repo_name} not to have #{expected} file"
  end

  description do
    "have a file called #{expected} in repository"
  end
end
