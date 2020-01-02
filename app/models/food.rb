class Food < ApplicationRecord
  validates_presence_of :name, :brand
  validates :upc,
            presence: true,
            uniqueness: { case_sensitive: false },
            numericality: true,
            length: { is: 12 }

  has_many :dish_foods, dependent: :destroy
  has_many :dishes, through: :dish_foods

  has_many :food_ingredients, dependent: :destroy
  has_many :ingredients, through: :food_ingredients
end
