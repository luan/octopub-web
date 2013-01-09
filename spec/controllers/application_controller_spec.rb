require 'spec_helper'

describe ApplicationController do
  describe "current_user" do
    context "when the user is logged in" do
      it "returns the logged user" do
        user = User.find_or_create_by_username 'some_username'
        session[:user_id] = user.id
        subject.send(:current_user).username = 'some_username'
      end
    end

    context "when the user it not logged in" do
      it "returns nil" do
        subject.send(:current_user).should be_nil
      end
    end
  end
end
