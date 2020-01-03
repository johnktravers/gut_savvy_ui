class MealsController < ApplicationController
  before_action :require_login

  def index; end

  def new
    session[:dishes] ||= []
    @dishes = Dish.find(session[:dishes])
  end

  def create
    meal = current_user.meals.new(title: params[:meal][:title])
    if dishes? && meal.save
      meal_success(meal)
    else
      meal_error(meal)
    end
  end

  private

  def dishes?
    session[:dishes].any?
  end

  def meal_error(meal)
    flash[:error] = meal.errors.full_messages.to_sentence if dishes?
    flash[:error] = "Meals cannot be created without any dishes." if !dishes?
    redirect_to new_meal_path
  end

  def meal_success(meal)
    meal.create_meal_dishes(session[:dishes])
    meal.create_meal_ingredients
    session.delete(:dishes)
    flash[:success] = "#{meal.title} has been added to your meals!"
    redirect_to gut_feelings_path
  end
end
