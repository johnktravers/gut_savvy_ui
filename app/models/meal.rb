class Meal < ApplicationRecord
  validates_presence_of :title
  belongs_to :user

  has_many :meal_dishes, dependent: :destroy
  has_many :dishes, through: :meal_dishes

  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients

  def create_meal_dishes(dish_ids)
    dish_ids.each do |dish_id|
      MealDish.create(meal_id: id, dish_id: dish_id)
    end
  end

  def create_meal_ingredients
    dishes.each do |dish|
      dish.foods.each do |food|
        food.ingredients.each do |ingredient|
          MealIngredient.create(meal_id: id, ingredient_id: ingredient.id)
        end
      end
    end
  end
end
