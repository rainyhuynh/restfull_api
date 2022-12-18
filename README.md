# README

Link: https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-one 

#rails new todos-api --api -T

Note that we’re using the --api argument to tell Rails that we want an API application and -T to exclude Minitest the default

testing framework. Don’t freak out, we’re going to write tests. We’ll be using RSpec instead to test our API. I find RSpec to be more expressive and easier to start with as compared to Minitest.

add spec gem
group :development, :test do
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end

rails generate rspec:install

rails g model Todo title:string created_by:string

rails g model Item name:string done:boolean todo:references

rails db:migrate

rails g controller Todos
rails g controller Items

mkdir spec/support && touch spec/support/request_spec_helper.rb

$ rails g model User name:string email:string password_digest:string
# run the migrations
$ rails db:migrate
# make sure the test environment is ready
$ rails db:test:prepare

rails g controller Users