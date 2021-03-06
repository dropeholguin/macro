source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use pg as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.8.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'foundation-rails' # gem for foundation
gem 'font-awesome-rails' # gem for font awesome icons
gem 'jquery-countdown-rails'

gem 'react-rails' # gem for react.js
gem 'webpack-rails'
# gem for user sign in and sign up
gem 'devise', '~> 4.2.0'
# gem for token based authentication with devise
gem 'simple_token_authentication', '~> 1.0'
gem 'omniauth', '~> 1.6.1'
gem 'oauth2', '~> 1.4'
# gems for sign in with linkedin
gem 'omniauth-linkedin', '~> 0.2.0'
gem 'linkedin', '~> 1.1.0'
# gem for markdown
gem 'simplemde-rails'
gem 'redcarpet'
#gem for create association between questions/answers
gem "cocoon"
#gems for roles and permissions
gem 'cancancan'
gem 'rolify'
#gem for search
gem 'tire'
#gem to help implement tags in a Rails app
gem 'acts-as-taggable-on'
#gem for autocomplete search
gem 'elasticsearch_autocomplete'
gem 'jquery-ui-rails'
#gem for gamification
gem 'gioco'
#gem for reputation
gem 'activerecord-reputation-system'
gem 'roo'
gem 'activeadmin', github: 'activeadmin'
gem "active_admin_import" , '3.0.0'
gem "aws-ses", "~> 0.6.0", require: 'aws/ses'
gem 'aws-sdk', '~> 2.3'
gem "paperclip", "~> 5.0.0"
gem 'faker'
gem 'active_admin_editor', github: 'ejholmes/active_admin_editor'
gem 'aasm'
gem 'airborne'
gem 'rest-client', '~> 1.7'

gem 'rack-cors', require: 'rack/cors'

source 'https://rails-assets.org' do
    gem 'rails-assets-alt'
    gem 'rails-assets-react-router'
    gem 'rails-assets-moment'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'dotenv-rails'
  gem 'jasmine-rails'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

