require 'rspec/core'
require 'capybara/rspec'
require 'capybara/email'
require 'capybara/poltergeist'
require 'capybara/slow_finder_errors'
require 'capybara-screenshot/rspec'
require 'poltergeist/suppressor'
require 'selenium/webdriver'
require 'phantomjs'

require 'config_spartan'
require 'active_support/all'
require 'mail'
require 'nokogiri'
require 'faker'

# Debug tools
require 'pp'
require 'ap'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
Dir[File.expand_path('../helpers/**/*.rb', __FILE__)].each { |path| require path }

Capybara.enable_aria_label = true
Capybara.default_max_wait_time = ENV['CAPYBARA_WAIT_TIME']&.to_i || 15.seconds

# Load test data config
Conf = ConfigSpartan.create do
  file 'spec/config/config.yml'
end

window_size = [1680, 1050]
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app,
    # Use gemmed phantomjs as per: https://github.com/colszowka/phantomjs-gem#manual-setup
    phantomjs: Phantomjs.path,
    # Screen resolution
    window_size: window_size,
    # Ignore errors because we'll be visiting some external sites.
    js_errors: false,
    timeout: 60
end
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: %w(window-size=#{window_size.join ','})
      }
    )
end
Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: %w(headless disable-gpu window-size=#{window_size.join ','})
      }
    )
end
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new app, browser: :firefox
end
Capybara.default_driver = ENV['BROWSER']&.to_sym || :poltergeist

# Configure automatic screenshots on failure.
Capybara.save_path = './screenshots'
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  example.metadata[:full_description].parameterize.underscore
end
Capybara::Screenshot.append_timestamp = false
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

RSpec.configure do |config|

  config.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end

  # Add basic asserts until specs are converted to expect(..).to syntax.
  config.expect_with :minitest

  # Allow using 'matcher do' in specs themselves.
  config.extend RSpec::Matchers::DSL

  # test helpers
  config.include LoginSpecHelper

  # Default format to color documentation.
  config.color = true
  config.formatter = :documentation

  config.before(:each) do
    Capybara.use_default_driver
  end
end
