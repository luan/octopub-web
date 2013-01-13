require 'spec_helper'

describe ApplicationController do
  describe "#authorize_user!" do
    context "when the user is logged in" do
      it "doesn't do anything" do
        subject.stub(current_user: stub)
        subject.should_not_receive(:redirect_to)
        subject.authorize_user!
      end
    end

    context "when the user it not logged in" do
      it "redirects back to the homepage" do
        subject.stub(current_user: nil)
        subject.should_receive(:redirect_to).with(root_url)
        subject.authorize_user!
      end
    end
  end

  describe "#current_user" do
    context "when the user is logged in" do
      it "returns the logged user" do
        user = User.find_or_create_by_username 'some_username'
        session[:user_id] = user.id
        subject.current_user.username = 'some_username'
      end
    end

    context "when the user it not logged in" do
      it "returns nil" do
        subject.current_user.should be_nil
      end
    end

    context "with an invalid session" do
      it "silently resets the session" do
        session[:user_id] = 123
        subject.current_user.should be_nil
        session[:user_id].should be_nil
      end
    end
  end
end
