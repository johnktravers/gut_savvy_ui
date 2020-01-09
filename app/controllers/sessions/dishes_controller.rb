class Sessions::DishesController < ApplicationController
  before_action :require_login

  def update
    session[:foods] << params[:food_id].to_i
    redirect_to new_dish_path
  end

  def destroy
    session[:dishes].delete(params[:dish_id].to_i)
    redirect_to new_meal_path
  end
end
