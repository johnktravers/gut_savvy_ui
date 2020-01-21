require 'rails_helper'

describe 'As a visitor or user' do
  describe 'when I visit the welcome page' do
    it 'I see an app summary and navbar with links to help, login, register' do
      visit root_path
      expect(page).to have_content('Gut Savvy')
      expect(page).to have_content('How it Works')
      expect(page).to have_content('Find out which ingredients strongly affect your gut')

      within 'nav' do
        expect(page).to have_link('Home')
        expect(page).to have_link('Help')
        expect(page).to have_link('Sign In')
      end
    end
  end
end
