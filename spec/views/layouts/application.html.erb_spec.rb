require 'spec_helper'

describe "layouts/application.html.erb" do
  it "display username when user is logged in" do
    view.stub(:current_user).and_return(stub username: 'sandijohn')
    render

    rendered.should include('sandijohn')
  end

  it "display login link when user is logged off" do
    view.stub(:current_user).and_return(nil)
    render

    rendered.should include('Sign in through GitHub')
  end
end

