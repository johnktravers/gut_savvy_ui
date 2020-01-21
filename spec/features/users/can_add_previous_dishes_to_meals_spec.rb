require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I have saved dishes' do
    it "I can reuse them in new meals" do
      omniauth_setup
      visit root_path
      click_link 'Sign in with Google'
      @user = User.last

      Faker::UniqueGenerator.clear # Clears used values for all generators
      Ingredient.destroy_all

      fi_1 = create(:food_ingredient)
      fi_2 = create(:food_ingredient)
      fi_3 = create(:food_ingredient)
      fi_4 = create(:food_ingredient)
      dish_1 = create(:dish)
      dish_2 = create(:dish)
      dish_1.foods.push(fi_1.food, fi_2.food)
      dish_2.foods.push(fi_3.food, fi_4.food)
      meal = create(:meal)
      meal.dishes.push(dish_1, dish_2)
      @user.meals.push(meal)

      visit '/dashboard'

      within "#dashboard-links" do 
        click_link 'Log a Meal'
      end

      within(".dish-history") do
        expect(page).to have_css("#dish-#{dish_1.id}")
        expect(page).to have_css("#dish-#{dish_2.id}")

        within("#dish-#{dish_1.id}") do
          click_button "Add"
        end
      end

      within('.current-dishes') do
        expect(page).to have_content(dish_1.name)
      end
    end
  end
end
