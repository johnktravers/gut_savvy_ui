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
  end
end
