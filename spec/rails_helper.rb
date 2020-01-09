require 'spec_helper'
require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  def omniauth_setup
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
  end
end
