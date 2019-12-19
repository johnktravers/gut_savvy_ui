# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'can authenticate my account with Google OAuth' do
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

    visit register_path
    click_link 'Create an Account using Google'
    user = User.last

    expect(current_path).to eq(help_path)
    expect(page).to have_content("Welcome, #{user.name}! Your account has been created using Google.")
  end
end
