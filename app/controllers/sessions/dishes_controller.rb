class Sessions::DishesController < ApplicationController
  before_action :require_login

  def update
    session[:foods] << params[:food_id]
    redirect_to new_dish_path
  end

  def destroy
    session[:dishes].delete(params[:dish_id])
    redirect_to new_meal_path
  end
end
