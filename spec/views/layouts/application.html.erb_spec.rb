require 'spec_helper'

describe "layouts/application.html.erb" do

  context "when the user is logged in" do
    before do
      view.stub(:current_user).and_return(stub username: 'sandijohn')
      render
    end

    it "display username when user is logged in" do
      rendered.should have_text 'sandijohn'
    end

    it "has a link to create a blog" do
      rendered.should have_link 'Create Blog'
    end
  end

  context "when the user is not logged in" do
    before do
      view.stub(:current_user).and_return(nil)
      render
    end

    it "display login link when user is logged off" do
      rendered.should include 'Sign in through GitHub'
    end
  end
end

