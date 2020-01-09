class FoodsController < ApplicationController
  before_action :require_food_session, :require_login
  skip_before_action :verify_authenticity_token, only: :create

  def new
    @food = Food.new
    @food.upc = params[:upc]
  end

  def create
    upc = get_upc
    if food = Food.find_by(upc: upc)
      session[:foods] << food.id.to_s
      redirect_to new_dish_path
    else
      service = GutSavvyService.new
      food_info = service.food_info(upc)
      if food_info && upc.length == 12
        food_success(food_info)
      else
        food_error
      end
    end
  end

  private

  def get_upc
    if params[:food]
      params[:food][:upc]
    else
      params[:upc][-12..-1]
    end
  end

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
