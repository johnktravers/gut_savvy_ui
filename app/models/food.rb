class Food < ApplicationRecord
  validates_presence_of :name, :brand
  validates :upc,
            presence: true,
            uniqueness: true,
            numericality: true,
            length: { is: 12 }

  has_many :dish_foods
  has_many :dishes, through: :dish_foods

  has_many :food_ingredients
  has_many :ingredients, through: :food_ingredients
end
