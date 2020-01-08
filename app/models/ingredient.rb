class Ingredient < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

  has_many :food_ingredients, dependent: :destroy
  has_many :foods, through: :food_ingredients

  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients

  def times_eaten
  end

  def avg_gut_feeling
  end

  def all_foods
  end
end
