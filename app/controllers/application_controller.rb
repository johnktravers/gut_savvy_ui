class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :one_day_old?,
                :three_days_old?,
                :localtime

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def localtime(meal)
    meal.created_at.localtime.to_datetime.strftime("%a, %b %d at %l:%M%P")
  end

  def one_day_old?(meal)
    (meal.updated_at.to_i - DateTime.now.to_i).abs >= 86400
  end

  def three_days_old?(meal)
    (meal.created_at.to_i - DateTime.now.to_i).abs >= 259200
  end

  def require_login
    render file: "/public/404" if current_user.nil?
  end
end
