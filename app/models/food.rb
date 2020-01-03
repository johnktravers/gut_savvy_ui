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

  def ingredient_list(food_info)
    food_info[:ingredients]
      .gsub(/ \[.*?\]/, '')
      .gsub(/ \(.*?\)/, '')
      .split('.').first
      .split(', 2%').first
      .split(', CONTAINS').first
      .split(', ')
  end

  def create_ingredients(food_info)
    ingredient_list(food_info).each do |name|
      unless ingredient = Ingredient.find_by(name: name)
        ingredient = Ingredient.create(name: name)
      end
      food_ingredients.create(ingredient: ingredient)
    end
  end
end
