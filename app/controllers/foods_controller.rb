class FoodsController < ApplicationController
  before_action :require_food_session, :require_login

  def new; end

  def create
    if food = Food.find_by(upc: params[:food][:upc])
      session[:foods] << food.id
      redirect_to new_dish_path
    else
      @service ||= GutSavvyService.new
      food_info = @service.food_info(params[:food][:upc])
      if food_info && params[:food][:upc] != ''
        food_success(food_info)
      else
        food_error
      end
    end
  end

  private

  def require_food_session
    render file: '/public/404' if session[:foods].nil?
  end

  def create_food(food_info)
    Food.create(
      name: food_info[:name],
      brand: food_info[:brand],
      upc: food_info[:upc]
    )
  end

  def food_success(food_info)
    food = create_food(food_info)
    food.create_ingredients(food_info[:ingredients])
    session[:foods] << food.id
    redirect_to new_dish_path
  end

  def food_error
    flash[:error] = 'Please enter a valid 12-digit UPC.'
    redirect_to new_food_path
  end
end
