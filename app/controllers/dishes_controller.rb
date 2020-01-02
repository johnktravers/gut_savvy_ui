class DishesController < ApplicationController
  def new
    @dish = Dish.new
    session[:current_foods] ||= []
    @foods = Food.find(session[:current_foods])
  end

  def create
    dish = Dish.new(name: params[:dish_name])

    if dish.save
      foods = Food.find(session[:current_foods])
      foods.each do |food|
        DishFood.create(dish: dish, food: food)
      end

      session[:current_foods] = nil
      session[:current_dishes] << dish.id

      flash[:success] = "#{dish.name} has been added to your meal!"
      redirect_to new_meal_path
    else
      flash[:error] = dish.errors.full_messages.to_sentence
      redirect_to new_dish_path
    end
  end

  def destroy
    session[:current_dishes].delete(params[:id].to_i)
    redirect_to new_meal_path
  end
end
