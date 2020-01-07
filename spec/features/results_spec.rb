require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'when I visit the results page' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)
    end

    it 'I can visit my results page from the landing page' do
      visit '/'
      within ".nav-item" do
        click_link 'Results'
      end

      expect(current_path).to eq(results_path)

      visit dashboard_path
      click_link 'See My Results'
      expect(current_path).to eq(results_path)
    end

    it 'I can see my consumed ingredients, their associated food, avg gut feeling and # of times eaten' do
      meal_1       = create(:meal, user: @user, gut_feeling: -5)
      meal_2       = create(:meal, user: @user, gut_feeling: 2)

      dish_1       = create(:dish) # eaten once
      dish_2       = create(:dish) # eaten once

      meal_dish_1  = create(:meal_dish, meal: meal_1, dish: dish_1)
      meal_dish_2  = create(:meal_dish, meal: meal_2, dish: dish_2)

      food_1       = create(:food) # eaten once (dish_1)
      food_2       = create(:food) # eaten twice (dishes 1, 2)
      food_3       = create(:food) # eaten twice (dishes 1, 2)
      food_4       = create(:food) # eaten once (dish_2)


      dish_food_1  = create(:dish_food, dish: dish_1, food: food_1)
      dish_food_2  = create(:dish_food, dish: dish_1, food: food_2)
      dish_food_3  = create(:dish_food, dish: dish_1, food: food_3)

      dish_food_4  = create(:dish_food, dish: dish_2, food: food_2)
      dish_food_5  = create(:dish_food, dish: dish_2, food: food_3)
      dish_food_6  = create(:dish_food, dish: dish_2, food: food_4)


      ingredient_1 = create(:ingredient) # found once (food_1)
      ingredient_2 = create(:ingredient) # found twice (foods 2, 3)
      ingredient_3 = create(:ingredient) # found thrice (foods 2, 3, 4)
      ingredient_4 = create(:ingredient) # found 4 times (foods 1, 2, 3, 4)


      food_ingredient_1  = create(:food_ingredient, food: food_1, ingredient: ingredient_1)
      food_ingredient_2  = create(:food_ingredient, food: food_1, ingredient: ingredient_4)

      food_ingredient_3  = create(:food_ingredient, food: food_2, ingredient: ingredient_2)
      food_ingredient_4  = create(:food_ingredient, food: food_2, ingredient: ingredient_3)
      food_ingredient_5  = create(:food_ingredient, food: food_2, ingredient: ingredient_4)

      food_ingredient_6  = create(:food_ingredient, food: food_3, ingredient: ingredient_2)
      food_ingredient_7  = create(:food_ingredient, food: food_3, ingredient: ingredient_3)
      food_ingredient_8  = create(:food_ingredient, food: food_3, ingredient: ingredient_4)

      food_ingredient_9  = create(:food_ingredient, food: food_4, ingredient: ingredient_3)
      food_ingredient_10 = create(:food_ingredient, food: food_4, ingredient: ingredient_4)


      meal_ingredient_1   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_1)
      meal_ingredient_2   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_2)
      meal_ingredient_3   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_2)
      meal_ingredient_4   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_3)
      meal_ingredient_5   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_3)
      meal_ingredient_6   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_4)
      meal_ingredient_7   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_4)
      meal_ingredient_8   = create(:meal_ingredient, meal: meal_1, ingredient: ingredient_4)

      meal_ingredient_9   = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)
      meal_ingredient_10  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)
      meal_ingredient_11  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_3)
      meal_ingredient_12  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)
      meal_ingredient_13  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)
      meal_ingredient_14  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)
      meal_ingredient_15  = create(:meal_ingredient, meal: meal_2, ingredient: ingredient_2)

    end
  end
end
