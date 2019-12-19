require 'rails_helper'

describe 'As a user' do
  describe 'when I visit the dashboard page' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@user)
    end

    it 'I can log a meal' do
      visit dashboard_path

      click_link 'Log a Meal'

      expect(current_path).to eq(new_meal_path)
    end

    it 'I can view my results' do
      visit dashboard_path

      click_link 'See My Results'

      expect(current_path).to eq(results_path)
    end
  end
end
