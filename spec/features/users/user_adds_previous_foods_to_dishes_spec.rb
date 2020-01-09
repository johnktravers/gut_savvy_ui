require 'rails_helper'

RSpec.describe 'As a logged in user' do
  before :each do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    meal = create(:meal, user: user)
    meal_dish = create(:meal_dish, meal: meal)
    dish_food_1 = create(:dish_food, dish: meal_dish.dish)
    dish_food_2 = create(:dish_food, dish: meal_dish.dish)
    dish_food_3 = create(:dish_food, dish: meal_dish.dish)
    @foods = [dish_food_1.food, dish_food_2.food, dish_food_3.food]
  end

  it 'I can add previously used foods to a new dish' do
    visit new_meal_path
    click_link 'Add a New Dish'

    within ".previous-foods" do
      within "#food-#{@foods[0].id}" do
        expect(page).to have_content(@foods[0].name)
        expect(page).to have_content(@foods[0].brand)
        expect(page).to have_content(@foods[0].upc)
      end
      within "#food-#{@foods[1].id}" do
        expect(page).to have_content(@foods[1].name)
        expect(page).to have_content(@foods[1].brand)
        expect(page).to have_content(@foods[1].upc)
      end
      within "#food-#{@foods[2].id}" do
        expect(page).to have_content(@foods[2].name)
        expect(page).to have_content(@foods[2].brand)
        expect(page).to have_content(@foods[2].upc)
      end
    end

    within ".previous-foods" do
      within("#food-#{@foods[1].id}") { click_button 'Add' }
    end

    expect(current_path).to eq(new_dish_path)

    within ".current-foods" do
      within "#food-#{@foods[1].id}" do
        expect(page).to have_content(@foods[1].name)
        expect(page).to have_content(@foods[1].brand)
        expect(page).to have_content(@foods[1].upc)
      end
    end
  end
end
