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

# Attempt to access API without a token
http :3000/todos

# Signup a new user - get token from here
http :3000/signup name=ash email=ash@email.com password=foobar password_confirmation=foobar


# Get new user todos
http :3000/todos \
Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0ODg5MDEyNjR9.7txvLgDzFdX5NIUGYb3W45oNIXinwB_ITu3jdlG5Dds'


# create todo for new user
http POST :3000/todos title=Beethoven \
Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0ODg5MDEyNjR9.7txvLgDzFdX5NIUGYb3W45oNIXinwB_ITu3jdlG5Dds'


# Get create todos
http :3000/todos \
Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0ODg5MDEyNjR9.7txvLgDzFdX5NIUGYb3W45oNIXinwB_ITu3jdlG5Dds'

# get auth token
http :3000/auth/login email=foo@bar.com password=foobar

# get todos from API v1
http :3000/todos Accept:'application/vnd.todos.v1+json' Authorization:'ey...AWH3FNTd3T0jMB7HnLw2bYQbK0g'

# attempt to get from API v2
http :3000/todos Accept:'application/vnd.todos.v2+json' Authorization:'ey...AWH3FNTd3T0jMB7HnLw2bYQbK0g'

rails g controller v2/todos

rails g serializer todo


##Increment Rails App Version
https://medium0.com/@eibrahim/increment-rails-app-version-51ca595b7342

rails generate task create_version

lib/tasks/create_version.rake

task :create_version do
  desc "create VERSION.  Use MAJOR_VERSION, MINOR_VERSION, BUILD_VERSION to override defaults"
  version_file = "#{Rails.root}/config/initializers/version.rb"
  major = ENV["MAJOR_VERSION"] || 1
  minor = ENV["MINOR_VERSION"] || 1
  build = ENV["BUILD_VERSION"] || `git describe --always --tags`
  version_string = "VERSION = #{[major.to_s, minor.to_s, build.strip]}\n"
  File.open(version_file, "w") {|f| f.print(version_string)}
  $stderr.print(version_string)
end