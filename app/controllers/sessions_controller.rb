class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']

    user = User.new(
      name: user_info['info']['name'],
      email: user_info['info']['email'],
      token: user_info['credentials']['token'],
      uid: user_info['uid']
    )

    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}! Your account has been created using Google."
    end
    redirect_to help_path
  end
end
