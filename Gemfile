# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '>= 2.7', '< 4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 6.2'
gem 'puma_worker_killer'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

gem 'dartsass-rails', '~> 0.4.1'
gem 'propshaft'

gem 'turbo-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'cocoon'
gem 'kaminari', '~> 1.2.2'
gem 'paranoia', '~> 2.6'

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'erb_lint', require: false
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console', '>= 3.3.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 3.1', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'minitest-ci'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
  gem 'webdrivers'
end
