class Dish < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :meal_dishes
  has_many :meals, through: :meal_dishes

  has_many :dish_foods
  has_many :foods, through: :dish_foods
end
