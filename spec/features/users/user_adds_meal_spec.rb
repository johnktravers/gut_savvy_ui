require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I navigate to the add a new meal page' do
    before(:each) do
      omniauth_setup
      visit root_path
      click_link 'Sign in with Google'
      @user = User.last
    end

    it "I see a button to add a new meal" do
      visit '/dashboard'

      within "#dashboard-links" do 
        click_link 'Log a Meal'
      end

      expect(current_path).to eq(new_meal_path)
    end

    it "I can add dishes to my meal" do
      visit new_meal_path

      click_link "Add a New Dish"

      expect(current_path).to eq(new_dish_path)

      click_link "Add a New Food"

      expect(current_path).to eq(new_food_path)
      expect(page).to have_css('#barcode-scanner')

      fill_in 'food[upc]', with: "041129077122"
      click_button "Add Food"

      expect(current_path).to eq(new_dish_path)
      within "#food-#{Food.find_by(upc: "041129077122").id}" do
        expect(page).to have_content("CLASSICO, TOMATO & BASIL PASTA SAUCE")
        expect(page).to have_content("New World Pasta Company")
      end

      click_link "Add a New Food"
      fill_in 'food[upc]', with: "078742058238"
      click_button "Add Food"

      within "#food-#{Food.find_by(upc: "078742058238").id}" do
        expect(page).to have_content("ITALIAN EXTRA VIRGIN OLIVE OIL")
        expect(page).to have_content("MEMBER'S MARK")
      end

      fill_in 'dish[name]', with: 'Oily Sauce'
      click_button 'Create Dish'

      expect(current_path).to eq(new_meal_path)
      expect(page).to have_content("Oily Sauce has been added to your meal!")

      within "#dish-#{Dish.find_by(name: "Oily Sauce").id}" do
        expect(page).to have_content("Oily Sauce")
      end

      click_link "Add a New Dish"
      click_link "Add a New Food"
      fill_in "food[upc]", with: "085239005392"
      click_button "Add Food"
      fill_in 'dish[name]', with: 'Cooked Pasta'
      click_button 'Create Dish'

      fill_in 'meal[title]', with: "Tomato Sauce Pasta"
      click_button 'Create Meal'

      expect(current_path).to eq(dashboard_path)
    end

    it "I can add a food that is already in the database" do
      Food.create(name: "CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL", upc: "041129077122", brand: "New World Pasta Company")

      visit new_meal_path
      click_link "Add a New Dish"
      click_link "Add a New Food"
      fill_in 'food[upc]', with: "041129077122"
      click_button 'Add Food'

      expect(current_path).to eq(new_dish_path)
      within "#food-#{Food.find_by(upc: "041129077122").id}" do
        expect(page).to have_content("CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL")
        expect(page).to have_content("New World Pasta Company")
      end
    end

    it "I see an error message if I submit an invalid food UPC" do
      visit new_meal_path
      click_link "Add a New Dish"
      click_link "Add a New Food"

      fill_in 'food[upc]', with: ""
      click_button 'Add Food'

      expect(page).to have_content("Please enter a valid 12-digit UPC.")

      fill_in 'food[upc]', with: "123123"
      click_button 'Add Food'

      expect(page).to have_content("Please enter a valid 12-digit UPC.")

      fill_in 'food[upc]', with: "346927590385"
      click_button 'Add Food'

      expect(page).to have_content("Please enter a valid 12-digit UPC.")
    end

    it "I see an error message if I try to create an empty dish" do
      visit new_meal_path
      click_link "Add a New Dish"
      fill_in 'dish[name]', with: "A Dish Name"
      click_button "Create Dish"

      expect(page).to have_content("Dishes cannot be created without any foods.")
      expect(current_path).to eq(new_dish_path)
    end

    it "I see an error message if I try to create a nameless dish" do
      visit new_meal_path
      click_link "Add a New Dish"
      click_link "Add a New Food"
      fill_in 'food[upc]', with: "041129077122"
      click_button 'Add Food'
      click_button 'Create Dish'

      expect(page).to have_content("Name can't be blank")
      expect(current_path).to eq(new_dish_path)
    end

    it "I see an error message if I try to create an empty meal" do
      visit new_meal_path
      fill_in 'meal[title]', with: 'A Meal Title'
      click_button 'Create Meal'

      expect(page).to have_content("Meals cannot be created without any dishes.")
      expect(current_path).to eq(new_meal_path)
    end

    it "I see an error message if I try to create a nameless meal" do
      visit new_meal_path
      click_link "Add a New Dish"
      click_link "Add a New Food"
      fill_in 'food[upc]', with: "041129077122"
      click_button 'Add Food'
      fill_in 'dish[name]', with: 'A Dish Name'
      click_button 'Create Dish'
      click_button 'Create Meal'

      expect(page).to have_content("Title can't be blank")
      expect(current_path).to eq(new_meal_path)
    end

    it "I see an error message if I try to navigate directly to dish or food paths" do
      visit new_dish_path

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit new_food_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
