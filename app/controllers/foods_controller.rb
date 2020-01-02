class FoodsController < ApplicationController
  def new; end

  def create
    unless food = Food.find_by(upc: params[:upc])
      response = get_food_info(params[:upc])

      food_info = JSON.parse(response.body)['foods'].first

      food = Food.new(
        name: food_info['description'],
        brand: food_info['brandOwner'],
        upc: params[:upc]
      )

      ingredient_list = food_info['ingredients'].split('.').first.split(', ')

      ingredient_list.each do |name|
        unless ingredient = Ingredient.find_by(name: name)
          ingredient = Ingredient.create!(name: name)
        end
        food.food_ingredients.create!(ingredient: ingredient)
      end
    end

    session[:current_foods] << food.id
    redirect_to new_dish_path
  end

  def destroy
    session[:current_foods].delete(params[:id].to_i)
    redirect_to new_dish_path
  end

  private

  def get_food_info(upc)
    Faraday.post('https://api.nal.usda.gov/fdc/v1/search') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['api_key'] = ENV['FDC_API_KEY']
      req.body = {generalSearchInput: upc}.to_json
    end
  end
end
