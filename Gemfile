source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'bootsnap', require: false
gem 'carrierwave', '~> 2.0'
gem 'cssbundling-rails'
gem 'devise'
gem 'devise-i18n'
gem 'fog-aws'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'
gem 'rails-i18n', '~> 7.0.0'
gem 'rmagick'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :production do
  gem 'pg'
end
