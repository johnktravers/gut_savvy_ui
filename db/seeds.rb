# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Meal.destroy_all
MealIngredient.destroy_all
Dish.destroy_all
DishFood.destroy_all
Food.destroy_all
FoodIngredient.destroy_all
Ingredient.destroy_all

user = User.create!(
  uid: '117045648135848876970',
  name: 'John Travers',
  email: 'john@example.com',
  token: ENV['FDC_API_KEY']
)

meal_hash = {
  'Breakfast, 2019-12-21 14:54:09 UTC, -4' =>
  [
    { 'Raspberry Greek Yogurt' =>
      {
        greek_yogurt:  '818290013613',
        raspberry_jam: '640671889988'
      }
    },
    { 'Cinnamon Raisin Bagel with Cream Cheese' =>
      {
        cream_cheese:     '070852992280',
        cin_raisin_bagel: '075925401249'
      }
    }
  ],

  'Dinner, 2019-12-22 01:01:31 UTC, 3' =>
  [
    { 'Bowties with Marinara' =>
      {
        farfalle:       '085239005392',
        marinara_sauce: '041129077122',
        olive_oil:      '078742058238'
      }
    },
    { 'Garlic Bread' =>
      {
        garlic_bread: '077890448410'
      }
    }
  ],

  'Breakfast, 2019-12-22 14:41:09 UTC, 0' =>
  [
    { 'Raisin Bran with Almond Milk' =>
      {
        raisin_bran: '708820033429',
        almond_milk: '025293001466'
      }
    }
  ],

  'Snack, 2019-12-22 19:34:25 UTC, -2' =>
  [
    { 'Peanut Toffee Buzz Bar' =>
      {
        peanut_toffee_bar: '722252166029'
      }
    }
  ],

  'Dinner, 2019-12-23 02:01:31 UTC, 4' =>
  [
    { 'Chicken Coconut Curry' =>
      {
        coconut_milk: '737628011506',
        curry_powder: '076114307557',
        chicken:      '796853100065'
      }
    }
  ],

  'Breakfast, 2019-12-23 14:20:17 UTC, 3' =>
  [
    { 'Hot Cereal' =>
      {
        hot_cereal:  '072400060083',
        almond_milk: '025293001466'
      }
    }
  ],

  'Lunch, 2019-12-23 19:34:25 UTC, 4' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721',
        mustard:      '011110865540'
      }
    },
    { 'Apple Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Snack, 2019-12-23 21:56:25 UTC, -4' =>
  [
    { 'Chocolate Sandwich Cookie' =>
      {
        chocolate_cookie: '845777005984'
      }
    }
  ],

  'Dinner, 2019-12-24 02:01:31 UTC, 0' =>
  [
    { 'Chicken Enchiladas' =>
      {
        wheat_tortilla:  '073731004197',
        chicken:         '796853100065',
        salsa:           '609207865858',
        enchilada_sauce: '054791100098',
        black_beans:     '099482441630',
        pepper_jack:     '275148002838'
      }
    }
  ]
}

def create_food_and_ingredients(upc, meal)
  unless food = Food.find_by(upc: upc)
    response = get_food_info(upc)

    food_info = JSON.parse(response.body)['foods'].first

    food = Food.create!(
      name: food_info['description'],
      brand: food_info['brandOwner'],
      upc: food_info['gtinUpc']
    )

    ingredient_list = food_info['ingredients']
      .gsub(/ \[.*?\]/, '')
      .gsub(/ \(.*?\)/, '')
      .split('.').first
      .split(', 2%').first
      .split(', CONTAINS').first
      .split(', ')

    ingredient_list.each do |name|
      unless ingredient = Ingredient.find_by(name: name)
        ingredient = Ingredient.create!(name: name)
      end
      food.food_ingredients.create!(ingredient: ingredient)
      meal.meal_ingredients.create!(ingredient: ingredient)
    end
    food
  end
  food
end

def get_food_info(upc)
  Faraday.post('https://api.nal.usda.gov/fdc/v1/search') do |req|
    req.headers['Content-Type'] = 'application/json'
    req.params['api_key'] = ENV['FDC_API_KEY']
    req.body = {generalSearchInput: upc}.to_json
  end
end


meal_hash.each do |meal_attrs, dishes|
  meal_attrs = meal_attrs.split(', ')
  meal = user.meals.create!(
    title: meal_attrs[0],
    created_at: meal_attrs[1],
    updated_at: meal_attrs[1],
    gut_feeling: meal_attrs[2]
  )

  dishes.each do |dish_data|
    dish = meal.dishes.create!(name: dish_data.keys.first)
    upcs = dish_data.values.first.values

    upcs.each do |upc|
      food = create_food_and_ingredients(upc, meal)
      food.dish_foods.create!(dish: dish)
    end
  end
end
