ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
end

# require 'factories'

# require 'rspec/rails'
RSpec.configure do |config|
  config.filter_run_excluding :slow
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
end
