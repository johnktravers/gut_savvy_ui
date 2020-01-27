class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']

    user = User.find_by(uid: user_info['uid'])

    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}! You have successfully logged in!"
      redirect_to dashboard_path
    else
      user = User.new(
        name: user_info['info']['name'],
        email: user_info['info']['email'],
        token: user_info['credentials']['token'],
        uid: user_info['uid']
      )

      if user.save
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}! Your account has been created using Google."
        redirect_to dashboard_path
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
