require 'rails_helper'

RSpec.describe 'As a vistor' do
  describe 'When I visit /help' do
    it 'I see a description of how to use the application' do
      visit '/help'

      expect(current_path).to eq(help_path)

      expect(page).to have_css('#what-is-gs')
      within('#what-is-gs') do
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
