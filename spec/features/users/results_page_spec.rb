require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my results page' do
    it 'I see a notice of required Gut Feelings before my results are rendered' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      create_list(:meal, 3, user: user)

      visit results_path

      expect(page).to have_content('You must add a Gut Feeling to 12 meals before the results page will show your results')
      expect(page).to have_content('You need to log 9 more meals with Gut Feelings')

      create_list(:meal, 9, user: user)

      visit results_path

      expect(page).to_not have_content('You must add a Gut Feeling to 12 meals before the results page will show your results')
      expect(page).to_not have_content('You need to log 9 more meals with Gut Feelings')
    end

    it "I see bar graphs for my best and worst ingredients based on gut feeling" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      meal_1 = create(:meal, user: user, gut_feeling: -5)
      meal_2 = create(:meal, user: user, gut_feeling: -4)
      meal_3 = create(:meal, user: user, gut_feeling: -3)
      meal_4 = create(:meal, user: user, gut_feeling: -2)
      meal_5 = create(:meal, user: user, gut_feeling: -1)
      meal_6 = create(:meal, user: user, gut_feeling: 0)
      meal_7 = create(:meal, user: user, gut_feeling: 1)
      meal_8 = create(:meal, user: user, gut_feeling: 2)
      meal_9 = create(:meal, user: user, gut_feeling: 3)
      meal_10 = create(:meal, user: user, gut_feeling: 4)
      meal_11 = create(:meal, user: user, gut_feeling: 5)
      meal_12 = create(:meal, user: user, gut_feeling: 2)

      create(:meal_ingredient, meal: meal_1)
      create(:meal_ingredient, meal: meal_2)
      create(:meal_ingredient, meal: meal_3)
      create(:meal_ingredient, meal: meal_4)
      create(:meal_ingredient, meal: meal_5)
      create(:meal_ingredient, meal: meal_6)
      create(:meal_ingredient, meal: meal_7)
      create(:meal_ingredient, meal: meal_8)
      create(:meal_ingredient, meal: meal_9)
      create(:meal_ingredient, meal: meal_10)
      create(:meal_ingredient, meal: meal_11)
      create(:meal_ingredient, meal: meal_12)

      visit '/results'

      within '#worst-ingredients-graph' do
        expect(page).to have_css('svg')
      end

      within '#best-ingredients-graph' do
        expect(page).to have_css('svg')
      end

      save_and_open_page
    end
  end
end
