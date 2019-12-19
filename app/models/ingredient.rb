class Ingredient < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

  has_many :food_ingredients
  has_many :foods, through: :food_ingredients

  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
end
