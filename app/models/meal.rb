class Meal < ApplicationRecord
  validates_presence_of :title, :gut_feeling
  validates_numericality_of :gut_feeling,
                            only_integer: true,
                            greater_than_or_equal_to: -5,
                            less_than_or_equal_to: 5

  belongs_to :user

  has_many :meal_dishes
  has_many :dishes, through: :meal_dishes

  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
end
