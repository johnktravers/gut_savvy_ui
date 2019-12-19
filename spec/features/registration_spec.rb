require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit the registration page' do
    xit 'I can connect to my Google account and register for the application' do
      visit register_path

      click_link 'Create an Account using Google'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Your account has been created using Google!')
    end
  end
end
