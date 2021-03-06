ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails'
require 'minitest/rails/capybara'
require 'minitest/reporters'

Dir[File.expand_path("test/support/**/*.rb")].each { |file| require file }

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in(user)
    cookies[:auth_token] = user.auth_token
  end
end

class LocaleTest < ActionDispatch::IntegrationTest
  before do
    self.default_url_options = {locale: I18n.locale}
  end

  register_spec_type(self) do |desc, *addl|
    addl.include? :locale
  end
end
