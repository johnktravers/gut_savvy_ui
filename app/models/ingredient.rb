class Ingredient < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

  has_many :food_ingredients, dependent: :destroy
  has_many :foods, through: :food_ingredients

  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients

  def times_eaten(user)
    meal_ingredients.joins(:meal).where(meals: {user_id: user.id}).count
  end

  def average_gut_feeling(user)
    meals.where(user_id: user.id).average(:gut_feeling)
  end
end
