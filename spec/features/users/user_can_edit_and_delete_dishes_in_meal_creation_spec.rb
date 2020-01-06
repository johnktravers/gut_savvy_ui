require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'When I visit the meal creation page with dishes in my current meal' do
    it "I can remove a dish from the meal I am building" do
      omniauth_setup
      visit sign_in_path
      click_link 'Sign in with Google'
      @user = User.last

      fi_1 = create(:food_ingredient)
      fi_2 = create(:food_ingredient)
      dish_1 = create(:dish)
      dish_1.foods.push(fi_1.food, fi_2.food)
      meal = create(:meal)
      meal.dishes.push(dish_1)
      @user.meals.push(meal)

      visit '/dashboard'
      click_link 'Log a Meal'

      within("#dish-#{dish_1.id}") do
        click_button "Add"
      end

      within('.current-dishes') do
        expect(page).to have_content(dish_1.name)
      end

      within('.current-dishes') do
        within("#dish-#{dish_1.id}") do
          click_button 'Delete'
        end
      end

      within('.current-dishes') do
        expect(page).to have_content("There are currently no dishes in this meal")
      end
    end
  end
end
