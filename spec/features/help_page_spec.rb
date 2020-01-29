require 'rails_helper'

RSpec.describe 'As a vistor' do
  describe 'When I visit the home page' do
    it 'I see a description of how to use the application' do
      visit '/home#how-it-works'

      expect(current_path).to eq(home_path)

      expect(page).to have_css('#help-section')
      within('#help-section') do
        expect(page).to have_content("What is Gut Savvy?")
      end

      expect(page).to have_css('#adding-meals')
      within('#adding-meals') do
        expect(page).to have_content("Adding Meals")
      end

      expect(page).to have_css('#gut-feelings')
      within('#gut-feelings') do
        expect(page).to have_content("Gut Feelings")
      end

      expect(page).to have_css('#interpreting-results')
      within('#interpreting-results') do
        expect(page).to have_content("Interpreting Results")
      end
    end
  end
end
