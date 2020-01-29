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
  uid:   '104836038866663614181',
  name:  'Rick Sanchez',
  email: 'gutsavvy@gmail.com',
  token: ENV['GOOGLE_TOKEN']
)

meal_hash = {
  'Breakfast, 2019-12-21 14:54:09 UTC, -3' =>
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
        toast:            '664541000013'
      }
    }
  ],

  'Dinner, 2019-12-21 01:01:31 UTC, 1' =>
  [
    { 'Bowties with Marinara' =>
      {
        farfalle:       '085239005392',
        marinara_sauce: '041129077122',
        olive_oil:      '078742058238'
      }
    }
  ],

  'Breakfast, 2019-12-22 14:41:09 UTC, 3' =>
  [
    { 'Raisin Bran with Almond Milk' =>
      {
        raisin_bran: '708820033429',
        almond_milk: '025293002043'
      }
    }
  ],

  'Snack, 2019-12-22 19:34:25 UTC, 0' =>
  [
    { 'Peanut Toffee Buzz Bar' =>
      {
        peanut_toffee_bar: '722252166029'
      }
    }
  ],

  'Dinner, 2019-12-22 23:01:31 UTC, 2' =>
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
        almond_milk: '025293002043'
      }
    }
  ],

  'Lunch, 2019-12-23 19:34:25 UTC, 2' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Apple Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Snack, 2019-12-23 21:56:25 UTC, -1' =>
  [
    { 'Chocolate Sandwich Cookie' =>
      {
        cookie: '859117001093'
      }
    }
  ],

  'Dinner, 2019-12-24 02:01:31 UTC, 0' =>
  [
    { 'Chicken Enchiladas' =>
      {
        chicken:         '796853100065',
        black_beans:     '099482441630',
        pepper_jack:     '275148002838'
      }
    }
  ],

  'Healthy Breakfast, 2019-12-25 14:54:09 UTC, 3' =>
  [
    { 'Almond Milk Cereal' =>
      {
        oat_cereal:  '058449771036',
        almond_milk: '025293002043'
      }
    },
    { 'Granola' =>
      {
        granola_with_sugar: '857376002134',
      }
    }
  ],

  'Lunch, 2019-12-25 19:34:25 UTC, 3' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Orange Juice' =>
      {
        orange_juice: '041303026793'
      }
    }
  ],

  'Treat, 2019-12-25 20:30:25 UTC, -4' =>
  [
    { 'Lowfat Ice Cream' =>
      {
        ice_cream: '044100244889'
      }
    }
  ],

  'Soup Dinner, 2019-12-25 23:01:31 UTC, 3' =>
  [
    { 'Vegetable Soup' =>
      {
        vegetable_soup: '021140022110'
      }
    }
  ],

  'Sweet Breakfast, 2019-12-26 14:50:09 UTC, -3' =>
  [
    { 'Lucky Charms Cereal' =>
      {
        sweetened_milk: '815473010414',
        sweet_cereal:   '042400069379'
      }
    }
  ],

  'Lunch, 2019-12-26 19:34:25 UTC, 2' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Apple Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Salad Dinner, 2019-12-26 23:21:31 UTC, 3' =>
  [
    { 'Aragula and Brocolli Salad' =>
      {
        brocolli_salad: '688267194115',
        aragula:        '688267011559'
      }
    }
  ],

  'Breakfast, 2019-12-27 14:21:17 UTC, 2' =>
  [
    { 'Hot Cereal' =>
      {
        hot_cereal:       '072400060083',
        toast:            '664541000013'
      }
    }
  ],

  'Lunch, 2019-12-27 19:32:25 UTC, -1' =>
  [
    { 'Pizza' =>
      {
        pizza: '856497004034'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2019-12-27 20:56:25 UTC, -2' =>
  [
    { 'Toffee' =>
      {
        peanut_toffee_bar: '722252166029'
      }
    }
  ],

  'Dinner, 2019-12-27 23:01:31 UTC, -3' =>
  [
    { 'Lasagna' =>
      {
        lasagna: '711667000264',
        cheese:  '073866210166'
      }
    }
  ],

  'Breakfast, 2019-12-28 14:21:17 UTC, 3' =>
  [
    { 'Granola and Cereal' =>
      {
        almond_milk:        '025293002043',
        raisin_bran:        '708820033429',
        granola_with_sugar: '857376002134'
      }
    }
  ],

  'Lunch, 2019-12-28 19:32:25 UTC, 2' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Juice' =>
      {
        orange_juice: '041303026793'
      }
    }
  ],

  'Snack, 2019-12-28 20:56:25 UTC, -5' =>
  [
    { 'Ice Cream' =>
      {
        ice_cream: '044100244889'
      }
    }
  ],

  'Dinner, 2019-12-28 23:01:31 UTC, 3' =>
  [
    { 'Salad' =>
      {
        aragula:    '688267011559',
        choy_salad: '895203001394'
      }
    },
    { 'Soup' =>
      {
        vegetable_soup: '021140022110'
      }
    }
  ],

  'Breakfast, 2019-12-29 14:21:17 UTC, -2' =>
  [
    { 'Yogurt and Cream Cheese Bagel' =>
      {
        greek_yogurt:     '818290013613',
        cream_cheese:     '070852992280',
        toast:            '664541000013'
      }
    }
  ],

  'Lunch, 2019-12-29 19:32:25 UTC, 2' =>
  [
    { 'Chicken Curry' =>
      {
        coconut_milk: '737628011506',
        curry_powder: '076114307557',
        chicken:      '796853100065'
      }
    },
    { 'Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Snack, 2019-12-29 20:56:25 UTC, -4' =>
  [
    { 'Ice Cream' =>
      {
        ice_cream: '044100244889'
      }
    }
  ],

  'Dinner, 2019-12-29 23:01:31 UTC, -2' =>
  [
    { 'Pizza' =>
      {
        pizza:  '856497004034',
        cheese: '073866210166'
      }
    }
  ],

  'Breakfast, 2019-12-30 14:21:17 UTC, -5' =>
  [
    { 'Milk' =>
      {
        sweetened_milk: '815473010414'
      }
    }
  ],

  'Lunch, 2019-12-30 19:32:25 UTC, 3' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2019-12-30 20:56:25 UTC, -1' =>
  [
    { 'Cookie' =>
      {
        cookie: '859117001093'
      }
    }
  ],

  'Dinner, 2019-12-30 23:01:31 UTC, 1' =>
  [
    { 'Pasta and Red Sauce' =>
      {
        farfalle:       '085239005392',
        marinara_sauce: '041129077122',
        olive_oil:      '078742058238'
      }
    }
  ],

  'Breakfast, 2019-12-31 14:21:17 UTC, -3' =>
  [
    { 'Cream Cheese Bagel' =>
      {
        cream_cheese:     '070852992280',
        toast:            '664541000013',
        greek_yogurt:     '818290013613'
      }
    }
  ],

  'Lunch, 2019-12-31 19:32:25 UTC, -1' =>
  [
    { 'Quesadilla' =>
      {
        chicken:         '796853100065',
        black_beans:     '099482441630',
        pepper_jack:     '275148002838'
      }
    },
    { 'Juice' =>
      {
        orange_juice: '041303026793'
      }
    }
  ],

  'Snack, 2019-12-31 20:56:25 UTC, -5' =>
  [
    { 'Ice Cream' =>
      {
        ice_cream: '044100244889'
      }
    }
  ],

  'Dinner, 2019-12-31 23:01:31 UTC, 3' =>
  [
    { 'Soup and Salad' =>
      {
        vegetable_soup: '021140022110',
        brocolli_salad: '688267194115',
        aragula:        '688267011559'
      }
    }
  ],

  'Breakfast, 2020-01-01 14:21:17 UTC, 2' =>
  [
    { 'Bagel and Jam' =>
      {
        raspberry_jam:    '640671889988',
        toast:            '664541000013',
        orange_juice:     '041303026793'
      }
    }
  ],

  'Lunch, 2020-01-01 19:32:25 UTC, 3' =>
  [
    { 'Salmon Burger' =>
      {
        salmon_burger: '884853610995'
      }
    },
    { 'Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Snack, 2020-01-01 20:56:25 UTC, -2' =>
  [
    { 'Cookie' =>
      {
        cookie: '859117001093'
      }
    }
  ],

  'Dinner, 2020-01-01 23:01:31 UTC, -2' =>
  [
    { 'Lasagna' =>
      {
        lasagna: '711667000264'
      }
    }
  ],

  'Breakfast, 2020-01-02 14:21:17 UTC, 2' =>
  [
    { 'Cereal' =>
      {
        hot_cereal:  '072400060083',
        almond_milk: '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-02 19:32:25 UTC, -3' =>
  [
    { 'Pizza' =>
      {
        pizza:        '856497004034',
        cheese:       '073866210166'
      }
    },
    { 'Juice' =>
      {
        orange_juice: '041303026793'
      }
    }
  ],

  'Snack, 2020-01-02 20:56:25 UTC, -4' =>
  [
    { 'Ice Cream' =>
      {
        ice_cream: '044100244889'
      }
    }
  ],

  'Dinner, 2020-01-02 23:01:31 UTC, 5' =>
  [
    { 'Soup and Salad' =>
      {
        vegetable_soup: '021140022110',
        brocolli_salad: '688267194115'
      }
    }
  ],

  'Breakfast, 2020-01-03 14:21:17 UTC, -4' =>
  [
    { 'Lucky Charms' =>
      {
        greek_yogurt:         '818290013613',
        cream_cheese:         '070852992280',
        sweet_cereal:         '042400069379',
        sweetened_milk:       '815473010414',
        cheese:               '073866210166'
      }
    }
  ],

  'Lunch, 2020-01-03 19:32:25 UTC, 3' =>
  [
    { 'Salad' =>
      {
        aragula:    '688267011559',
        choy_salad: '895203001394'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2020-01-03 20:56:25 UTC, -1' =>
  [
    { 'Toffee' =>
      {
        peanut_toffee_bar: '722252166029'
      }
    }
  ],

  'Dinner, 2020-01-03 23:01:31 UTC, 3' =>
  [
    { 'Salmon Burger' =>
      {
        salmon_burger: '884853610995',
        aragula:       '688267011559'
      }
    }
  ],

  'Breakfast, 2020-01-04 14:21:17 UTC, 1' =>
  [
    { 'Raisin Bran and Yogurt' =>
      {
        greek_yogurt:     '818290013613',
        raspberry_jam:    '640671889988',
        toast:            '664541000013',
        raisin_bran:      '708820033429',
        almond_milk:      '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-04 19:32:25 UTC, 1' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721',
        pepper_jack:  '275148002838'
      }
    },
    { 'Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ],

  'Snack, 2020-01-04 20:56:25 UTC, -2' =>
  [
    { 'Cookie' =>
      {
        cookie: '859117001093'
      }
    }
  ],

  'Dinner, 2020-01-04 23:01:31 UTC, 4' =>
  [
    { 'Soup and Salad' =>
      {
        vegetable_soup: '021140022110',
        brocolli_salad: '688267194115',
        aragula:        '688267011559',
        choy_salad:     '895203001394'
      }
    }
  ],

  'Breakfast, 2020-01-05 14:21:17 UTC, 3' =>
  [
    { 'Raisin Bran' =>
      {
        raisin_bran: '708820033429',
        almond_milk: '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-05 19:32:25 UTC, 1' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Juice' =>
      {
        orange_juice: '041303026793'
      }
    }
  ],

  'Snack, 2020-01-05 20:56:25 UTC, 5' =>
  [
    { 'Ginger' =>
      {
        ginger: '074574108783'
      }
    }
  ],

  'Dinner, 2020-01-05 23:01:31 UTC, -4' =>
  [
    { 'Lasagna' =>
      {
        lasagna:     '711667000264',
        cheese:      '073866210166',
        pepper_jack: '275148002838'
      }
    }
  ],

  'Breakfast, 2020-01-06 14:21:17 UTC, -5' =>
  [
    { 'Milk' =>
      {
        cream_cheese:     '070852992280',
        sweetened_milk:   '815473010414'
      }
    }
  ],

  'Lunch, 2020-01-06 19:32:25 UTC, 3' =>
  [
    { 'Salmon Burger' =>
      {
        salmon_burger: '884853610995'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2020-01-06 20:56:25 UTC, 4' =>
  [
    { 'Ginger' =>
      {
        ginger: '074574108783'
      }
    }
  ],

  'Dinner, 2020-01-06 23:01:31 UTC, 3' =>
  [
    { 'Soup and Salad' =>
      {
        vegetable_soup: '021140022110',
        brocolli_salad: '688267194115'
      }
    }
  ],

  'Breakfast, 2020-01-07 14:21:17 UTC, 3' =>
  [
    { 'Raisin Bran' =>
      {
        raisin_bran: '708820033429',
        almond_milk: '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-07 19:32:25 UTC, 3' =>
  [
    { 'Chicken Curry' =>
      {
        coconut_milk: '737628011506',
        curry_powder: '076114307557',
        chicken:      '796853100065'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2020-01-07 20:56:25 UTC, 4' =>
  [
    { 'Ginger' =>
      {
        ginger: '074574108783'
      }
    }
  ],

  'Dinner, 2020-01-07 23:01:31 UTC, 0' =>
  [
    { 'Pizza' =>
      {
        pizza: '856497004034'
      }
    }
  ],

  'Breakfast, 2020-01-08 14:21:17 UTC, -3' =>
  [
    { 'Sweet Cereal' =>
      {
        sweet_cereal: '042400069379',
        sweetened_milk:      '815473010414'
      }
    }
  ],

  'Lunch, 2020-01-08 19:32:25 UTC, 4' =>
  [
    { 'Turkey Sandwich' =>
      {
        wheat_bread:  '025911000130',
        turkey:       '011110005687',
        mixed_greens: '041443112721'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2020-01-08 20:56:25 UTC, 5' =>
  [
    { 'Ginger' =>
      {
        ginger: '074574108783'
      }
    }
  ],

  'Dinner, 2020-01-08 23:01:31 UTC, 4' =>
  [
    { 'Salmon Burger' =>
      {
        salmon_burger: '884853610995',
        aragula:       '688267011559'
      }
    }
  ],

  'Breakfast, 2020-01-09 14:21:17 UTC, 2' =>
  [
    { 'Hot Cereal' =>
      {
        raspberry_jam:    '640671889988',
        toast:            '664541000013',
        hot_cereal:       '072400060083',
        almond_milk:      '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-09 19:32:25 UTC, 2' =>
  [
    { 'Salad' =>
      {
        aragula:    '688267011559',
        choy_salad: '895203001394'
      }
    },
    { 'Juice' =>
      {
        cranberry_juice: '725439975698'
      }
    }
  ],

  'Snack, 2020-01-09 20:56:25 UTC, 4' =>
  [
    { 'Ginger' =>
      {
        ginger: '074574108783'
      }
    }
  ],

  'Dinner, 2020-01-09 23:01:31 UTC, -1' =>
  [
    { 'Chicken Quesadilla' =>
      {
        chicken:         '796853100065',
        black_beans:     '099482441630',
        pepper_jack:     '275148002838'
      }
    }
  ],

  'Breakfast, 2020-01-10 14:21:17 UTC, 3' =>
  [
    { 'Cereal and Bagel' =>
      {
        raspberry_jam:    '640671889988',
        toast:            '664541000013',
        oat_cereal:       '058449771036',
        almond_milk:      '025293002043'
      }
    }
  ],

  'Lunch, 2020-01-10 19:32:25 UTC, 2' =>
  [
    { 'Salmon Burger' =>
      {
        salmon_burger: '884853610995',
        aragula:       '688267011559'
      }
    },
    { 'Juice' =>
      {
        apple_juice: '842798100506'
      }
    }
  ]
}

def create_food_and_ingredients(upc, meal)
  if food = Food.find_by(upc: upc)
    food.ingredients.each do |ingredient|
      meal.meal_ingredients.create!(ingredient: ingredient)
    end
  else
    response = get_food_info(upc)

    food_info = JSON.parse(response.body)['foods'].first

    food = Food.create!(
      name: food_info['description'],
      brand: food_info['brandOwner'],
      upc: food_info['gtinUpc']
    )

    ingredient_list = process_ingredients(food_info['ingredients'])

    ingredient_list.each do |name|
      unless ingredient = Ingredient.find_by(name: name)
        ingredient = Ingredient.create!(name: name)
      end
      food.food_ingredients.create!(ingredient: ingredient)
      meal.meal_ingredients.create!(ingredient: ingredient)
    end
  end
  food
end

def process_ingredients(ingredient_list)
  formatted_ingredients    = format_ingredients(ingredient_list)
  consolidated_ingredients = consolidate_ingredients(formatted_ingredients).uniq.compact
  validate_ingredients(consolidated_ingredients)
end

def format_ingredients(ingredient_list)
  ingredient_list
    .gsub(/ \[.*?\]/, '')
    .gsub(/ \(.*?\)/, '')
    .gsub(/\(\)\*/, '')
    .gsub('ORGANIC ', '')
    .gsub('100%', '')
    .gsub('REAL', '')
    .split('.').first
    .split(', 2%').first
    .split(', CONTAINS').first
    .split(', ')
end

def consolidate_ingredients(ingredients)
  ingredients.map! do |ingredient|
    if ingredient.include?("MILK")
      ingredient.replace "MILK" unless not_dairy_milk?(ingredient)
    elsif ingredient.include?("SALT")
      ingredient.replace "SALT"
    else
      ingredient
    end
  end
end

def not_dairy_milk?(ingredient)
  ingredient.include?("ALMOND")  ||
  ingredient.include?("SOY")     ||
  ingredient.include?("CASHEW")  ||
  ingredient.include?("COCONUT") ||
  ingredient.include?("FLAX")    ||
  ingredient.include?("HEMP")    ||
  ingredient.include?("RICE")    ||
  ingredient.include?("OAT")
end

def validate_ingredients(ingredients)
    ingredients.delete_if { |ingredient| ingredient.include?("WATER") }
    ingredients.delete_if { |ingredient| ingredient.include?("NATURAL FLAVOR") }
    ingredients.delete_if { |ingredient| ingredient.include?("ARTIFICIAL FLAVOR") }
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
