source 'https://rubygems.org'

gem 'rails'
gem 'pg'
gem 'jbuilder'
gem 'plan-logic'
gem 'cortex-ruby'
gem 'jwt'

group :production do
  gem 'unicorn'
end

group :test do
  gem 'rubocop'
  gem 'json_expressions'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'
  gem 'terminal-notifier'
  gem 'gnuplot'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'byebug'
end
