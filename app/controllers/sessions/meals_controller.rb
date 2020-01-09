class Sessions::MealsController < ApplicationController
  def update
    dish_id = params[:dish_id].to_i
    session[:dishes] << dish_id unless session[:dishes].includes?(dish_id)
    redirect_to new_meal_path
  end
end
