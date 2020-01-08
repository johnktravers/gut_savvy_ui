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
      within ".navbar-nav" do
        click_link 'Results'
      end

      expect(current_path).to eq(results_path)

      visit dashboard_path
      click_link 'See My Results'
      expect(current_path).to eq(results_path)
    end

    it 'I can see my consumed ingredients, their associated food, avg gut feeling and # of times eaten' do
      Faker::UniqueGenerator.clear # Clears used values for all generators
      Ingredient.destroy_all
      meal_1       = create(:meal, user: @user, gut_feeling: 3)
      meal_2       = create(:meal, user: @user, gut_feeling: -5)

      dish_1       = create(:dish) # eaten once
      dish_2       = create(:dish) # eaten once

      food_1       = create(:food) # eaten once (dish_1)
      food_2       = create(:food) # eaten twice (dishes 1, 2)
      food_3       = create(:food) # eaten twice (dishes 1, 2)
      food_4       = create(:food) # eaten once (dish_2)

      ingredient_1 = create(:ingredient) # found once (food_1), eaten 1 time, rating (3) #
      ingredient_2 = create(:ingredient) # found twice (foods 2, 3), eaten 4 times, ratings (3, 3, -5, -5), avg -1 #
      ingredient_3 = create(:ingredient) # found thrice (foods 2, 3, 4), eaten 5 times, ratings (3, 3, -5, -5, -5), avg -1.8 #
      ingredient_4 = create(:ingredient) # found 4 times (foods 1, 2, 3, 4), eaten 6 times, ratings (3, 3, 3, -5, -5, -5), avg -1 #


      create(:meal_dish, meal: meal_1, dish: dish_1)
      create(:meal_dish, meal: meal_2, dish: dish_2)


      create(:dish_food, dish: dish_1, food: food_1)
      create(:dish_food, dish: dish_1, food: food_2)
      create(:dish_food, dish: dish_1, food: food_3)

      create(:dish_food, dish: dish_2, food: food_2)
      create(:dish_food, dish: dish_2, food: food_3)
      create(:dish_food, dish: dish_2, food: food_4)


      create(:food_ingredient, food: food_1, ingredient: ingredient_1)
      create(:food_ingredient, food: food_1, ingredient: ingredient_4)

      create(:food_ingredient, food: food_2, ingredient: ingredient_2)
      create(:food_ingredient, food: food_2, ingredient: ingredient_3)
      create(:food_ingredient, food: food_2, ingredient: ingredient_4)

      create(:food_ingredient, food: food_3, ingredient: ingredient_2)
      create(:food_ingredient, food: food_3, ingredient: ingredient_3)
      create(:food_ingredient, food: food_3, ingredient: ingredient_4)

      create(:food_ingredient, food: food_4, ingredient: ingredient_3)
      create(:food_ingredient, food: food_4, ingredient: ingredient_4)


      create(:meal_ingredient, meal: meal_1, ingredient: ingredient_1)
      create_list(:meal_ingredient, 2, meal: meal_1, ingredient: ingredient_2)
      create_list(:meal_ingredient, 2, meal: meal_1, ingredient: ingredient_3)
      create_list(:meal_ingredient, 3, meal: meal_1, ingredient: ingredient_4)

      create_list(:meal_ingredient, 2, meal: meal_2, ingredient: ingredient_2)
      create_list(:meal_ingredient, 3, meal: meal_2, ingredient: ingredient_3)
      create_list(:meal_ingredient, 3, meal: meal_2, ingredient: ingredient_4)

      visit results_path

      within "#ingredient-history" do
        within "#ingredient-#{ingredient_1.id}" do
          expect(page).to have_content(ingredient_1.name)
          expect(page).to have_content('3.0')
          expect(page).to have_content('1')
          expect(page).to have_content(food_1.name)
        end
        within "#ingredient-#{ingredient_2.id}" do
          expect(page).to have_content(ingredient_2.name)
          expect(page).to have_content('-1.0')
          expect(page).to have_content('4')
          expect(page).to have_content(food_2.name)
          expect(page).to have_content(food_3.name)
        end
        within "#ingredient-#{ingredient_3.id}" do
          expect(page).to have_content(ingredient_3.name)
          expect(page).to have_content('-1.8')
          expect(page).to have_content('5')
          expect(page).to have_content(food_2.name)
          expect(page).to have_content(food_3.name)
          expect(page).to have_content(food_4.name)
        end
        within "#ingredient-#{ingredient_4.id}" do
          expect(page).to have_content(ingredient_4.name)
          expect(page).to have_content('-1.0')
          expect(page).to have_content('6')
          expect(page).to have_content(food_1.name)
          expect(page).to have_content(food_2.name)
          expect(page).to have_content(food_3.name)
          expect(page).to have_content(food_4.name)
        end
      end
    end
  end
end
