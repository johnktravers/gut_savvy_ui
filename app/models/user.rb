class User < ApplicationRecord
  validates_presence_of :name, :email, :token, :uid
  validates_uniqueness_of :uid, case_sensitive: false
  validates :email,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :meals, dependent: :destroy

  has_many :meal_dishes, through: :meals
  has_many :dishes, through: :meal_dishes

  has_many :dish_foods, through: :dishes
  has_many :foods, through: :dish_foods

  has_many :meal_ingredients, through: :meals
  has_many :ingredients, through: :meal_ingredients

  def ratings_needed
    12 - meals.where.not(gut_feeling: nil).count
  end

  def worst_ingredients_data
    worst_ingredients.map do |ingredient|
      {
        name: ingredient.name,
        avg_gut_feeling: ingredient.avg_gut_feeling.abs.round(2)
      }
    end[0..24]
  end

  def ingredient_table_data
    ingredients
      .joins(:meals)
      .includes(:foods)
      .select('ingredients.*, avg(meals.gut_feeling) as avg_gut_feeling, sqrt(count(ingredients.id)) as frequency')
      .group('ingredients.id')
      .order('avg_gut_feeling')
  end

  def best_ingredients_data
    best_ingredients.map do |ingredient|
      {
        name: ingredient.name,
        avg_gut_feeling: ingredient.avg_gut_feeling.round(2)
      }
    end[0..24]
  end
  def sorted_ingredients(flag, count)
    if flag == 'best'
      order = 'DESC'
      range = [0, 6]
    else
      order = 'ASC'
      range = [-6, 0]
    end

    ingredients
      .joins(:meals)
      .select('ingredients.*, avg(meals.gut_feeling) as avg_gut_feeling')
      .group('ingredients.id')
      .having('avg(meals.gut_feeling) > ? AND avg(meals.gut_feeling) < ?', range[0], range[1])
      .having('count(ingredients.id) > 2')
      .order("avg_gut_feeling #{order}, ingredients.name")
      .limit(count)
  end

  def gut_feelings_over_time
    feeling_hash = meals.where.not(gut_feeling: nil).group('meals.created_at::date').average(:gut_feeling)

    feeling_hash.map do |date, gut_feeling|
      {
        date: date,
        avg_gut_feeling: gut_feeling.round(2)
      }
    end
  end
end
