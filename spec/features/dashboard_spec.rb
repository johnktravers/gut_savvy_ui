require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'when I visit the dashboard page' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@user)

      @unrated_meal = create(:unrated_meal, user: @user)

      visit dashboard_path
    end

    it 'I can log a meal' do
      click_link 'Log a Meal'

      expect(current_path).to eq(new_meal_path)
    end

    it 'I can use a link to view my results' do
      click_link 'See My Results'

      expect(current_path).to eq(results_path)
    end

    it 'I can see a table of my previous meals and assign a gut feeling for 72 hours after meal creation' do
      day_old_meal       = create(:unrated_meal,
                                  user: @user,
                                  created_at: DateTime.now.prev_day
                                  )
      three_day_old_meal = create(:unrated_meal,
                                  user: @user,
                                  created_at: DateTime.now.prev_day(3)
                                  )
      rated_meal         = create(:meal, user: @user)

      within "#meal-#{rated_meal.id}" do
        expect(page).to have_content(rated_meal.title)
        expect(page).to have_content(rated_meal.gut_feeling)
        expect(page).to have_content(rated_meal.created_at.localtime.to_s)
        expect(page).to_not have_link('Add Gut Feeling')
      end

      within "#meal-#{three_day_old_meal.id}" do
        expect(page).to_not have_link('Add Gut Feeling')
      end

      within "#meal-#{@unrated_meal.id}" do
        expect(page).to have_content(@unrated_meal.title)
        expect(page).to have_content(@unrated_meal.created_at.localtime.to_s)
        expect(page).to have_link('Add Gut Feeling')
      end

      within "#meal-#{day_old_meal.id}" do
        expect(page).to have_link('Add Gut Feeling')
        click_link 'Add Gut Feeling'
      end

      expect(current_path).to eq(edit_meal_path(day_old_meal))
    end

    it 'I can update my gut feelings up to 24 hours after gut feeling creation' do
      day_old_meal = create(:meal,
                            user: @user,
                            created_at: DateTime.now.prev_day(2),
                            updated_at: DateTime.now.prev_day
                            )
      rated_meal   = create(:meal,
                            user: @user,
                            created_at: DateTime.now.prev_day(2)
                            )

      within "#meal-#{day_old_meal.id}" do
        expect(page).to_not have_link('Update')
      end

      within "#meal-#{@unrated_meal.id}" do
        expect(page).to_not have_link('Update')
      end

      within "#meal-#{rated_meal.id}" do
        expect(page).to have_link('Update')
        click_link 'Update'
      end

      expect(current_path).to eq(edit_meal_path(rated_meal))
    end
  end

  it 'I can delete meals' do
    rated_meal = create(:meal, user: @user)

    within "#meal-#{@unrated_meal.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq(dashboard_path)
    @unrated_meal.reload
    expect(Meal.find(@unrated_meal.id)).to eq(nil)

    within "#meal-#{rated_meal.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq(dashboard_path)
    rated_meal.reload
    expect(Meal.find(rated_meal.id)).to eq(nil)

    expect(page).to_not have_content('Meal Title')
    expect(page).to have_content('There are currently no Meals')
  end
end

describe 'As a visitor' do
  describe 'when I visit the dashboard page' do
    it 'I receive a 404 error' do
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
