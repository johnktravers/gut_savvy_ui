require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'When I edit a meal' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)
    end

    it 'I can add a gut feeling and then see it on my dashboard' do
      unrated_meal = create(:unrated_meal, user: @user)

      visit edit_meal_path(unrated_meal)
      expect(page).to have_content(unrated_meal.title)

      select '-3', from: 'meal[gut_feeling]'
      click_button 'Update'

      unrated_meal.reload
      expect(unrated_meal.gut_feeling).to eq(-3)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You have successfully recorded your gut feeling for #{unrated_meal.title}")

      within "#meal-#{unrated_meal.id}" do
        expect(page).to have_content('-3')
      end
    end

    it 'I can update gut feelings and then see it on my dashboard' do
      rated_meal = create(:meal, gut_feeling: 1, user: @user)

      visit edit_meal_path(rated_meal)
      expect(page).to have_content(rated_meal.title)

      expect(find_field('meal[gut_feeling]').value).to eq('1')

      select '-3', from: 'meal[gut_feeling]'
      click_button 'Update'

      rated_meal.reload
      expect(rated_meal.gut_feeling).to eq(-3)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You have successfully recorded your gut feeling for #{rated_meal.title}")

      within "#meal-#{rated_meal.id}" do
        expect(page).to have_content('-3')
      end
    end
  end
end
