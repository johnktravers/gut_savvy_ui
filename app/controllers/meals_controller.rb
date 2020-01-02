class MealsController < ApplicationController
  def new
    @meal = Meal.new
    session[:current_dishes] ||= []
    @dishes = Dish.find(session[:current_dishes])
  end

  def create
    meal = current_user.meals.new(title: params[:meal_title])

    if meal.save
      dishes = Dish.find(session[:current_dishes])
      dishes.each do |dish|
        MealDish.create!(meal: meal, dish: dish)
        dish.foods.each do |food|
          food.ingredients.each do |ingredient|
            MealIngredient.create!(meal: meal, ingredient: ingredient)
          end
        end
      end

      binding.pry

      session[:current_dishes] = nil

      flash[:success] = "#{meal.title} has been successfully logged!"
      redirect_to dashboard_path
    else
      flash[:error] = meal.errors.full_messages.to_sentence
      redirect_to new_meal_path
    end
  end
end
