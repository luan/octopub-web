require 'spec_helper'

describe BlogsController do
  context "when logged in" do
    before do
      @user = User.create! do |u|
        u.username = 'user'
        u.token = 'the-token'
      end
      controller.stub(:current_user).and_return(@user)
    end

    describe "GET 'new'" do
      it "returns http success" do
        get :new
        response.should be_success
        response.should render_template 'new'
      end

      it "initializes a blog object on the user" do
        get :new
        assigns(:blog).should be_a Blog
        assigns(:blog).user.should == @user
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        blog = stub(repo: 'some-name').as_null_object
        @user.octopub.should_receive(:create_blog).with('some name').and_return(blog)
        post :create, blog: { name: 'some name' }
        @user.blogs.should have(1).blog
        @user.blogs.last.name.should == 'some name'
      end
    end
  end

  context "when not logged in" do
    before { controller.stub(:current_user).and_return(nil) }
    subject { response }

    describe "GET 'new'" do
      before { get :new }

      it { should_not be_success }
      it { should redirect_to root_url }
    end

    describe "POST 'create'" do
      before { post :create, blog: { name: 'some name' } }

      it { should_not be_success }
    end
  end
end
