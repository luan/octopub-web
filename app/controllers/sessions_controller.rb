class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    username = auth['extra']['raw_info']['login']

    user = User.find_by_username(username) || User.create_with_username(username)
    session[:user_id] = user.id
    redirect_to root_url
  end
end
