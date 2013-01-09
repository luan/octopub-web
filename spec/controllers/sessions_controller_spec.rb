require 'spec_helper'

describe SessionsController do
  describe "POST 'create'" do
    before do
      OmniAuth.config.test_mode = true
    end

    shared_examples_for "a user from github" do
      before { post :create }

      it "fills in the user info" do
        mock_auth = OmniAuth.config.mock_auth[:github]
        username = mock_auth[:extra][:raw_info][:login]
        token = mock_auth[:credentials][:token]

        User.find_by_username(username).token.should == token
      end

      it "logs the user in" do
        session[:user_id].should == subject.id
      end

      it "redirects the user to the root path" do
        response.should redirect_to root_url
      end
    end

    context "when the user coming back" do
      subject { User.create! { |u| u.username = 'oldguy' } }

      before do
        subject
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: 'github',
          credentials: {
            token: 'the-token'
          },
          extra: {
            raw_info: {
              login: 'oldguy',
              email: 'foo@bar.baz'
            }
          }
        })

        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      end

      it_behaves_like "a user from github"

      it "does not create a user record" do
        expect { post :create }.not_to change(User, :count)
      end
    end

    context "when the user is new" do
      subject { User.last }

      before do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: 'github',
          credentials: {
            token: 'the-token'
          },
          extra: {
            raw_info: {
              login: 'newguy',
              email: 'bin@bar.baz'
            }
          }
        })

        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      end

      it_behaves_like "a user from github"

      it "creates a new user record" do
        expect { post :create }.to change(User, :count).by(1)
      end
    end
  end
end
