source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'jbuilder'
gem 'jwt'

group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl'
  gem 'simplecov'
  gem 'rubocop'
  gem 'json_expressions'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'
  gem 'terminal-notifier'
  gem 'gnuplot'
end

group :test, :development do#
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'byebug'
end
