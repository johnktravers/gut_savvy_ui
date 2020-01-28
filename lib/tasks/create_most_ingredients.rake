task :create_most_ingredients => [:environment] do

  user = User.create!(
    uid:   '106085974130307620137',
    name:  'Fly fishin Rick',
    email: 'gutsavvyingredients@gmail.com',
    token: ENV['GOOGLE_TOKEN_2']
  )
  meal = user.meals.create!(title: "Everything You Have", gut_feeling: 0)
  dish = meal.dishes.create!(name: "All the bacon and eggs you have")
  def create_foods_and_ingredients(foods, meal, dish)
    foods.each do |food_data|
      if food = Food.find_by(upc: food_data["gtinUpc"])
        food.ingredients.each do |ingredient|
          meal.meal_ingredients.create(ingredient: ingredient)
        end
      else
        processed_food_data = process_food_data(food_data)

          food = Food.create(
            name: processed_food_data[:name],
            brand: processed_food_data[:brand],
            upc: processed_food_data[:upc]
          )

          processed_food_data[:ingredients].each do |name|
            unless ingredient = Ingredient.find_by(name: name)
              ingredient = Ingredient.create(name: name)
            end
            food.food_ingredients.create(ingredient: ingredient)
            meal.meal_ingredients.create(ingredient: ingredient)
          end
          food.dish_foods.create(dish: dish)
      end
    end
  end

  def process_food_data(food_data)
    if food_data['ingredients']
      food = { name: food_data['description'],
              brand: food_data['brandOwner'],
                upc: food_data['gtinUpc'],
        ingredients: process_ingredients(food_data['ingredients']) }
    food
    end
  end

  def process_ingredients(ingredient_list)
    formatted_ingredients    = format_ingredients(ingredient_list)
    consolidated_ingredients = consolidate_ingredients(formatted_ingredients).uniq.compact
    validate_ingredients(consolidated_ingredients)
  end

  def consolidate_ingredients(ingredients)
    ingredients.map! do |ingredient|
      if ingredient.include?("MILK")
        ingredient.replace("MILK") unless not_dairy_milk?(ingredient)
      elsif ingredient.include?("SALT")
        ingredient.replace("SALT")
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
  end

  def format_ingredients(ingredient_list)
    ingredient_list
      .gsub(/ \[.*?\]/, '')
      .gsub(/ \(.*?\)/, '')
      .gsub('ORGANIC ', '')
      .split('.').first
      .split(', 2%').first
      .split(', CONTAINS').first
      .split(', ')
  end

  def compile_food_data(pages)
    page_numbers = (1..pages).to_a
    food_array = []
    until page_numbers == []
      response = get_food_info(page_numbers.shift)
      food_array += JSON.parse(response.body)['foods'] if JSON.parse(response.body)['foods']
    end
    food_array
  end

  def get_food_info(page_number)
    Faraday.post('https://api.nal.usda.gov/fdc/v1/search') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['api_key'] = ENV['FDC_API_KEY']
      req.body = { includeDataTypeList: ["Branded"],
                           pageNumber: page_number,
                            sortField: "publishedDate",
                        sortDirection:"desc" }.to_json
    end
  end

  # Set number of pages to pull data from, 50 foods per page #
  foods_data = compile_food_data(200)
  create_foods_and_ingredients(foods_data, meal, dish)
end
