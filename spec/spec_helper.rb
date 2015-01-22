require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
end
require 'factory_girl'
require 'factories'
require 'database_cleaner'
require 'devise'
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Devise::TestHelpers, type: :controller

  DatabaseCleaner[:active_record].strategy = :truncation
  config.before(:each) { DatabaseCleaner.start }

  # then, whenever you need to clean the DB
  config.after(:each) { DatabaseCleaner.clean }
end
