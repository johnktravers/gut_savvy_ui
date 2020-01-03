class Meal < ApplicationRecord
  belongs_to :user

  has_many :meal_dishes, dependent: :destroy
  has_many :dishes, through: :meal_dishes

  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients

  validates_presence_of :title
  validates_numericality_of :gut_feeling,
                            only_integer: true,
                            greater_than_or_equal_to: -5,
                            less_than_or_equal_to: 5,
                            if: :has_gut_feeling?

  def has_gut_feeling?
    gut_feeling ? true : false # ternary operator
  end

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
