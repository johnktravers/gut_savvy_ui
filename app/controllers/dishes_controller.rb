class DishesController < ApplicationController
  before_action :require_dish_session, :require_login

  def new
    session[:foods] ||= []
    @foods = Food.find(session[:foods])
  end

  def edit
    dish = Dish.find(params[:id])
    session[:foods] = dish.foods.pluck(:id)
    session[:dishes].delete(params[:id].to_i)
    dish.destroy if dish.meal_dishes.empty?
    redirect_to new_dish_path
  end

  def create
    dish = Dish.new(name: params[:dish][:name])
    if foods? && dish.save
      dish_success(dish)
    else
      dish_error(dish)
    end
  end

  private

  def require_dish_session
    render file: '/public/404' if session[:dishes].nil?
  end

  def foods?
    session[:foods].any?
  end

  def dish_error(dish)
    flash[:error] = dish.errors.full_messages.to_sentence if foods?
    flash[:error] = 'Dishes cannot be created without any foods.' unless foods?
    redirect_to new_dish_path
  end

  def dish_success(dish)
    dish.create_dish_foods(session[:foods])
    session.delete(:foods)
    session[:dishes] << dish.id
    flash[:success] = "#{dish.name} has been added to your meal!"
    redirect_to new_meal_path
  end
end
