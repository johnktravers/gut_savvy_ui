require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    omniauth_setup

    visit sign_in_path
    click_link 'Sign in with Google'
    @user = User.last
  end

  it 'can authenticate my account with Google OAuth' do
    expect(current_path).to eq(help_path)
    expect(page).to have_content("Welcome, #{@user.name}! Your account has been created using Google.")
  end

  it 'I can log out of the application' do
    click_link 'Logout'

    expect(current_path).to eq(root_path)

    within 'nav' do
      expect(page).to_not have_link(@user.name)
      expect(page).to have_link('Sign In')
    end
  end

  it 'can login with Google OAuth' do
    click_link 'Logout'
    click_link 'Sign In'

    expect(current_path).to eq(sign_in_path)
    click_link 'Sign in with Google'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{@user.name}! You have successfully logged in!")
  end
end
