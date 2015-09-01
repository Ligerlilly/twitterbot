require 'sinatra/activerecord'
require 'pg'
require 'sinatra'
require 'sinatra/jsonp'
require 'rubygems'
require 'twitter'
require 'pry'
require './secrets'
require 'sinatra/reloader'
require './lib/user.rb'
require './lib/tweet.rb'

class TwitterFetcher < Sinatra::Base
  helpers Sinatra::Jsonp

  @@twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key       = ENV['consumer_key']
    config.consumer_secret    = ENV['consumer_secret']
    config.oauth_token        = ENV['oauth_token']
    config.oauth_token_secret = ENV['oath_token_secret']
  end

  get '/' do
     erb :index
  end

  get '/search' do
    erb :search
  end

  post '/search' do
    query = params['query']
    if query.include?(' ')
      query.gsub!(' ', '+')
    end

    redirect "/search/#{query}"
  end

  get '/search/:query' do
    query = params['query']
    @lats = []
    @lngs = []

    if query.include?('+')
      query.gsub!('+', ' ')
    end
    @tweets = []
    @raw_tweets = []
    @@twitter_client.search("#{query}", {result_type: 'recent', geocode: "45.5434085,-122.654422,8mi", count: 50}).map do |tweet|

      if tweet.urls[0].respond_to? :url
        instagram = tweet.urls[0].url
      end

      if tweet.geo.coordinates.first.inspect != "<null>"
        @lats.push(tweet.geo.coordinates.first)
        @lngs.push(tweet.geo.coordinates.last)
      end

      # fav_count = tweet.user.favourites_count || 0
      # User.create({name: tweet.user.name, favourites_count: fav_count, followers_count: tweet.user.followers_count, location: tweet.user.location, geolat: tweet.geo.coordinates[0], geolong: tweet.geo.coordinates[1]})
      # Tweet.create({ tweet: tweet.text })
      # @raw_tweets.push(tweet)
      # @tweets.push "<img src='#{tweet.user.profile_image_url}' alt='img'> #{tweet.user.screen_name}: #{tweet.text} **** #{tweet.user.location} ++++ <a href='#{instagram}'>Instagram</a>"
    end

    @raw_tweets
    #
    # @raw_tweets.each do |tweet|
    #   @lats = tweet.geo.coordinates.first
    #   @lngs = tweet.geo.coordinates.last
    # end

    @lats
    @lngs


    # parse
    @names = []
    @location = []
    @description = []
    @favorites_count = []
    @followers_count = []
    @raw_tweets.each do |tweet_object|
      @names.push(tweet_object.user.name)
      @location.push(tweet_object.user.location)
      @description.push(tweet_object.user.description)
      @favorites_count.push(tweet_object.user.favorites_count)
      @followers_count.push(tweet_object.user.followers_count)
    end
    erb :tweets
  end
end
