class Dish < ApplicationRecord
  validates_presence_of :name

  has_many :meal_dishes, dependent: :destroy
  has_many :meals, through: :meal_dishes

  has_many :dish_foods, dependent: :destroy
  has_many :foods, through: :dish_foods

  def create_dish_foods(food_ids)
    food_ids.each do |food_id|
      DishFood.create(dish_id: id, food_id: food_id)
    end
  end
end
