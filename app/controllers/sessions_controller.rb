class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    username = auth['extra']['raw_info']['login']
    token = auth['credentials']['token']

    user = User.find_or_initialize_by_username(username)
    user.token = token
    user.save!

    session[:user_id] = user.id
    redirect_to root_url
  end
end
