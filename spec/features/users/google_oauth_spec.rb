require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      'provider' => 'google_oauth2',
      'uid' => '123456789',
      'info' => {
        'name' => 'John Doe',
        'email' => 'john.doe@example.com',
        'first_name' => 'John',
        'last_name' => 'Doe',
        'image' => 'https://lh3.googleusercontent.com/url/photo.jpg'
      },
      'credentials' => {
        'token' => 'token',
        'refresh_token' => 'another_token',
        'expires_at' => 1_354_920_555,
        'expires' => true
      }
    )

    Rails
      .application
      .env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

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
