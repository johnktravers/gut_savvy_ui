class Sessions::FoodsController < ApplicationController
  def destroy
    session[:foods].delete(params[:food_id])
    redirect_to new_dish_path
  end
end
