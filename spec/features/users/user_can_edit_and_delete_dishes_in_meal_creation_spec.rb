require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'When I visit the meal creation page with dishes in my current meal' do
    before(:each) do
      omniauth_setup
      visit sign_in_path
      click_link 'Sign in with Google'
      @user = User.last
    end

    it "I can remove a dish from the meal I am building" do
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

    it 'I can click the edit button to go to a prefilled dish creation page' do
      visit '/dashboard'
      click_link 'Log a Meal'

      click_link "Add a New Dish"
      click_link "Add a New Food"
      fill_in 'food[upc]', with: "041129077122"
      click_button "Add Food"
      click_link "Add a New Food"
      fill_in 'food[upc]', with: "078742058238"
      click_button "Add Food"
      fill_in 'dish[name]', with: 'Oily Sauce'
      click_button 'Create Dish'

      id = Dish.find_by(name: 'Oily Sauce').id

      within ".current-dishes" do
        within "#dish-#{id}" do
          click_link 'Edit'
        end
      end

      within ".current-foods" do
        expect(page).to have_content("CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL")
        expect(page).to have_content("ITALIAN EXTRA VIRGIN OLIVE OIL")
      end

      click_link "Add a New Food"
      fill_in 'food[upc]', with: "640671889988"
      click_button "Add Food"
      fill_in 'dish[name]', with: 'Raspberry Pasta Sauce'
      click_button 'Create Dish'

      within('.current-dishes') do
        expect(page).to have_content("Raspberry Pasta Sauce")
      end
    end
  end
end
