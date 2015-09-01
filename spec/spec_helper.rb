ENV['RACK_ENV'] = 'test'
require 'sinatra/activerecord'
require 'rspec'
require 'pg'
require './lib/user.rb'
require './lib/tweet.rb'
require 'capybara/rspec'
require 'shotgun'

require './app'

RSpec.configure do |config|
  config.after(:each) do
    User.all.each do |task|
      task.destroy
    end
    Tweet.all.each do |task|
      task.destroy
    end
  end
end
