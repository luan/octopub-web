require './lib/octopub'

Github = Struct.new(:params) unless defined? Github

describe Octopub do
  before do
    @octopub = Octopub.new 'token'
    @github = @octopub.github
    @octopub.stub(login: 'userbuser')
  end

  describe "#create_blog" do
    it "creates a repository" do
      @github.stub(repos: stub)
      @github.repos.should_receive(:create).with(name: 'a-blog', auto_init: true)
      blog = @octopub.create_blog('A Blog')
      blog.should be_a Octopub::Blog
      blog.user.should == 'userbuser'
      blog.repo.should == 'a-blog'
      blog.github.should == @github
    end
  end
end

