class BlogsController < ApplicationController
  before_filter :authorize_user!

  def new
    @blog = current_user.blogs.build
  end

  def create
    current_user.create_blog params[:blog][:name]
    redirect_to root_url
  end
end
