class FoodsController < ApplicationController
  before_action :require_food_session, :require_login

  def new; end

  def create
    unless food = Food.find_by(upc: params[:food][:upc])
      service = FDCService.new
      food_info = service.food_info(params[:food][:upc])
      if food_info && params[:food][:upc] != ''
        food_success(food_info)
      else
        food_error
      end
    else
      session[:foods] << food.id
      redirect_to new_dish_path
    end
  end

  private

  def require_food_session
    render file: "/public/404" if session[:foods].nil?
  end

  def create_food(food_info)
    Food.create(
      name: food_info[:description],
      brand: food_info[:brandOwner],
      upc: food_info[:gtinUpc]
    )
  end

  def food_success(food_info)
    food = create_food(food_info)
    food.create_ingredients(food_info)
    session[:foods] << food.id.to_s
    redirect_to new_dish_path
  end

  def food_error
    flash[:error] = "Please enter a valid 12-digit UPC."
    redirect_to new_food_path
  end
end
