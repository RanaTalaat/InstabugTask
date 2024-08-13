source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.4"

gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "mysql2", "~> 0.5.6"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'sidekiq'
gem "elasticsearch-rails", "~> 8.0"
gem "elasticsearch-model", "~> 8.0"
gem "elasticsearch", "~> 8.14.0"
gem "faraday", "~> 2.10.1"
gem "faraday-net_http", "~> 3.1.1"
gem "hashie", "~> 5.0"
gem "multi_json", "~> 1.15.0"
gem 'redis', '~> 4.0'
gem "bcrypt", "~> 3.1.7"
gem 'uuidtools'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
