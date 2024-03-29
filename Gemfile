source 'https://rubygems.org'
ruby "2.2.2"

gem 'rails', '4.2.0'
gem 'dotenv-rails', :groups => [:development, :test]

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bcrypt', '~> 3.1.7'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'mini_magick'
gem 'will_paginate', '3.0.7'
gem 'devise'
gem 'nokogiri'
gem 'newrelic_rpm'
# gem 'open-uri'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development do
  gem 'bullet'
end

group :development, :test do
  gem 'sqlite3'
#  gem 'debugger'
  gem 'better_errors'
  gem 'faker', '1.4.2'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rerun'
  # RSpec rails for specs
  gem 'rspec-rails', '~> 3.0'
  # capybara to assist with feature and integration specs
  gem 'capybara'
  # purge data from db
  gem 'database_cleaner'
  # rubocop to enforce syntax practices
  gem 'rubocop'
  gem 'shoulda-matchers', require: false
  gem 'factory_girl_rails', '~> 4.0'
end

group :production do
  gem 'pg'
  gem 'unicorn', '4.8.3'
end
