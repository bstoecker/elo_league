ruby '2.2.0'

source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'jbuilder'
gem 'jwt'
gem 'active_model_serializers'

# assets related
gem 'sass-rails'
gem 'coffee-rails'
gem 'bower-rails'
gem 'font-awesome-rails'
gem 'handlebars_assets'
gem 'uglifier'
gem 'emblem-rails'
gem 'twitter-bootstrap-rails'
gem 'simple_form'

gem 'devise'

group :production do
  gem 'unicorn'
  gem 'rails_12factor', group: :production
end

group :test do
  gem 'factory_girl'
  gem 'simplecov'
  gem 'rubocop'
  gem 'json_expressions'
  gem 'json_spec'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'
  gem 'terminal-notifier'
  gem 'gnuplot'
end

group :test, :development do
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'byebug'
end
