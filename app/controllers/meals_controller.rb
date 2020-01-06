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

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update(meal_params)
      flash[:success] = "You have successfully recorded your gut feeling for #{@meal.title}"
      redirect_to dashboard_path
    end
  end

  def destroy
    meal = Meal.find(params[:id])
    meal_title = meal.title
    if meal.destroy
      flash[:success] = "You have successfully deleted #{meal_title}"
    end
    redirect_to dashboard_path
  end

  private

  def meal_params
    params.require(:meal).permit(:gut_feeling)
  end

  def dishes?
    session[:dishes].any?
  end

  def meal_error(meal)
    flash[:error] = meal.errors.full_messages.to_sentence if dishes?
    flash[:error] = 'Meals cannot be created without any dishes.' unless dishes?
    redirect_to new_meal_path
  end

  def meal_success(meal)
    meal.create_meal_dishes(session[:dishes])
    meal.create_meal_ingredients
    session.delete(:dishes)
    flash[:success] = "#{meal.title} has been added to your meals!"
    redirect_to dashboard_path
  end
end
