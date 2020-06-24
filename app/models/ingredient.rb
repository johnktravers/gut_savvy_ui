class Ingredient < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true

  has_many :food_ingredients, dependent: :destroy
  has_many :foods, through: :food_ingredients

  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients

  def self.to_data
    all.map do |ingredient|
      {
        name: ingredient.name,
        avg_gut_feeling: ingredient.avg_gut_feeling.abs.round(2)
      }
    end
  end
end
