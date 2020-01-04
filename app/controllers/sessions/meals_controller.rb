class Sessions::MealsController < ApplicationController
  def update
    session[:dishes] << params[:dish_id]
    redirect_to new_meal_path
  end
end
