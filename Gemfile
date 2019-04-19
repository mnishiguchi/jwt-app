# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 6.0.0.beta3" # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem "awesome_print"
gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password
gem "bootsnap", ">= 1.4.1", require: false # Reduces boot times through caching; required in config/boot.rb
gem "jbuilder", "~> 2.5" # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "knock"
gem "pg", ">= 0.18", "< 2.0" # Use postgresql as the database for Active Record
gem "puma", "~> 3.11" # Use Puma as the app server
gem "react-rails"
gem "sass-rails", "~> 5.0" # Use SCSS for stylesheets
gem "simple_command"
gem "strip_attributes"
gem "turbolinks", "~> 5" # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "webpacker", ">= 4.0.0.rc.3" # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker

# gem 'image_processing', '~> 1.2' # Use Active Storage variant
# gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rubocop", require: false
  gem "rubocop-performance"
end

group :development do
  gem "foreman"
  gem "guard"
  gem "guard-minitest"
  gem "listen", ">= 3.0.5", "< 3.2" # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0" # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
end

group :test do
  gem "capybara", ">= 2.15" # Adds support for Capybara system testing and selenium driver
  gem "chromedriver-helper"
  gem "selenium-webdriver" # Easy installation and use of chromedriver to run system tests with Chrome
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
