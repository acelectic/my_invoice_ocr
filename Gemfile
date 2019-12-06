source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use jdbcmysql as the database for Active Record
# gem 'activerecord-jdbcmysql-adapter', "~> 60.0.rc1", git: "https://github.com/jruby/activerecord-jdbc-adapter", branch: "master"
gem 'activerecord-jdbcmysql-adapter'
gem 'activerecord-oracle_enhanced-adapter'
gem 'composite_primary_keys'
gem "activerecord-import"
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# gem 'jquery-rails'
# gem 'rails-ujs'
# gem 'bootstrap-sass'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem "warbler"
gem "jruby-openssl"
gem 'jruby-jars', '9.2.7.0'
gem 'listen', '>= 3.0.5', '< 3.2'

gem 'sidekiq'
gem 'sidekiq-pro'
gem 'redis-rails'
gem 'redis-namespace'
gem "sidekiq-cron"
gem 'sidekiq-status'
gem 'kaminari'
gem 'bootstrap-datepicker-rails'
gem "config"
gem 'rails-settings-cached'
gem 'loading_screen'
gem 'turbolinks-form'

group :development, :test do
  gem "pry-rails"
  gem "annotate"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'guard-rspec'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'minitest-focus'
  gem 'simplecov', require: false
  gem 'mocha'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
