class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']

    name = user_info['info']['name']
    email = user_info['info']['email']
    token = user_info['credentials']['token']
    uid = user_info['uid']

    user = User.new(name: name, email: email, token: token, uid: uid)

    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'We cannot create a Gut Savvy account with that Google account'
      redirect_to register_path
    end
  end
end
