require 'rails_helper'

RSpec.describe 'As a logged in user adding a new dish' do
  it 'I can delete a food before creating a dish' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    meal = create(:meal, user: user)
    meal_dish = create(:meal_dish, meal: meal)
    dish_food = create(:dish_food, dish: meal_dish.dish)
    food = dish_food.food

    visit new_meal_path
    click_link 'Add a New Dish'

    within '.previous-foods' do
      within("#food-#{food.id}") { click_button 'Add' }
    end

    within '.current-foods' do
      within("#food-#{food.id}") { click_button 'Delete' }
    end

    expect(current_path).to eq(new_dish_path)

    within '.current-foods' do
      expect(page).to_not have_css("#food-#{food.id}")
    end
  end
end
