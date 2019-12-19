require 'rails_helper'

describe 'As a visitor or user' do
  describe 'when I visit the welcome page' do
    it 'I see an app summary and navbar with links to help, login, register' do
      visit root_path
      expect(page).to have_content('Welcome to Gut Savvy')
      expect(page).to have_content('About the Application')
      expect(page).to have_content('Gut Savvy is a new app that helps')

      within 'nav' do
        expect(page).to have_link('Home')
        expect(page).to have_link('Help')
        expect(page).to have_link('Register')
        expect(page).to have_link('Login')
      end
    end
  end
end
