source "https://rubygems.org"

ruby "3.2.2"

gem 'dotenv', '~> 2.1', '>= 2.1.1'
gem 'devise', '~> 4.9.2'
gem "font-awesome-sass", "~> 6.5"
gem 'jquery-rails'
gem 'jquery-slick-rails'
gem 'jquery-ui-rails', '>= 6.0.1'
gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'factory_bot_rails'
  gem "byebug", "~> 11.1"
  gem "rspec-rails", "~> 6.1"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :test, :development do
  gem 'shoulda-matchers', '~> 5.0'
  gem "faker", "~> 3.2"
end
