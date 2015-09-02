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
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/array'

class TwitterFetcher < Sinatra::Base
  include WillPaginate::Sinatra::Helpers

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

  get '/data' do
    @users = User.paginate(:page => params[:page], :per_page => 35)
    @tweets = Tweet.all
    erb :data
  end

  get '/data/search' do
    erb :search_data
  end

  post '/data/search' do
    @query = params.fetch('query')

    @results = Tweet.find_tweets(@query)
    erb :search_results
  end

  get '/search' do
    erb :search
  end


  # search local
  # post '/search_local' do
  #   query = params['query']
  #   if query.include?(' ')
  #     query.gsub!(' ', '+')
  #   end
  #
  #   redirect "/search_local/#{query}"
  # end


  post '/search' do
    query = params['query']
    if query.include?(' ')
      query.gsub!(' ', '+')
    end

    redirect "/search/#{query}"
  end
  #, geocode: "45.5434085,-122.654422,8mi"
  get '/search/:query' do
    query = params['query']
    @lats = []
    @lngs = []

    if query.include?('+')
      query.gsub!('+', ' ')
    end
    @tweets = []
    @raw_tweets = []
    @@twitter_client.search("#{query}", {result_type: 'recent', count: 1000}).map do |tweet|
      if tweet.urls[0].respond_to? :url
        instagram = tweet.urls[0].url
      end

      if tweet.geo.coordinates.first.inspect != "<null>"
        @lats.push(tweet.geo.coordinates.first)
        @lngs.push(tweet.geo.coordinates.last)
      end


      fav_count = tweet.user.favourites_count || 0
      begin
        @user = User.create({name: tweet.user.name, favourites_count: fav_count, followers_count: tweet.user.followers_count, location: tweet.user.location, geolat: tweet.geo.coordinates[0], geolong: tweet.geo.coordinates[1]})
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid
      end

      if @user
        user_id = @user.id
      else
        user_id = 0
      end

      begin
        Tweet.create({ tweet: tweet.text, user_id: user_id })
      rescue ActiveRecord::RecordNotUnique

      end

      @raw_tweets.push(tweet)
      @tweets.push "<img src='#{tweet.user.profile_image_url}' alt='img'> #{tweet.user.screen_name}: #{tweet.text} **** #{tweet.user.location} ++++ <a href='#{instagram}'>Instagram</a>"

    end

    @raw_tweets

    @lats
    @lngs

    @users = User.all

    @raw_tweets


    erb :results

  end

  get '/election' do
    erb :election
  end

  get '/election/democrats' do
    erb :democrats
  end

  get '/election/republicans' do
    erb :republicans
  end

  get '/election/totals' do
    @total = Tweet.count
    @tweets = Tweet.all
    @clinton = 0
    @sanders = 0
    @chafee = 0
    @webb = 0
    @trump = 0
    @carson = 0
    @bush = 0
    @cruz = 0
    @rubio = 0
    @walker = 0

    @clinton += @tweets.find_tweets('hillary').count
    @clinton += @tweets.find_tweets('clinton').count
    @sanders += @tweets.find_tweets('sanders').count
    @sanders += @tweets.find_tweets('bernie').count
    @chafee  += @tweets.find_tweets('chafee').count
    @chafee  += @tweets.find_tweets('lincoln').count

    @webb    += @tweets.find_tweets('webb').count || 0
    @webb    += @tweets.find_tweets('jim').count || 0
    @trump   += @tweets.find_tweets('trump').count
    @trump   += @tweets.find_tweets('donald').count
    @carson  += @tweets.find_tweets('carson').count
    @carson  += @tweets.find_tweets('ben').count
    @bush    += @tweets.find_tweets('bush').count
    @bush    += @tweets.find_tweets('jeb').count
    @cruz    += @tweets.find_tweets('cruz').count
    @cruz    += @tweets.find_tweets('ted').count
    @rubio   += @tweets.find_tweets('marco').count
    @rubio   += @tweets.find_tweets('rubio').count
    @walker  += @tweets.find_tweets('scott').count
    @walker  += @tweets.find_tweets('walker').count
    erb :totals
  end

  post '/search-filter' do

    # @users = User.paginate(:page => params[:page], :per_page => 35)
    # @tweets = Tweet.all

    redirect "/search-filter/#{params['filter']}"
  end
  get '/search-filter/:filter' do
    @tweets = Tweet.find_tweets(params["filter"]).paginate(:page => params[:page], :per_page => 25)
    erb :filter_results
  end


  get '/election/democrats/clinton' do
    @candidate = "Clinton"


    @tweets = Tweet.find_tweets('clinton')

    @matches = 0
    @matches += Tweet.find_tweets('clinton').count
    @matches += Tweet.find_tweets('clinton hillary').count



    @users = User.find_by_tweets(@tweets)


    @total   = Tweet.count

    # @lats = []
    # @lngs = []
    # @valid_users = []
    # @users.each do |user|
    #   if user.geolat != nil
    #     @lats.push(user.geolat)
    #   end
    #   if user.geolong != nil
    #     @lngs.push(user.geolong)
    #   end
    #   if user.geolong != nil && user.geolat != nil
    #     @valid_users.push(user.name)
    #   end
    # end
    #@valid_users

    erb :election_tweets
  end

  get '/election/democrats/sanders' do
    @candidate = "Bernie Sanders"

    @tweets = Tweet.find_tweets('sanders')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('sanders').count
    @matches += Tweet.find_tweets('bernie sanders').count

    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/democrats/chafee' do
    @candidate = "Lincoln Chafee"
    @tweets = Tweet.find_tweets('chafee')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('chafee').count
    @matches += Tweet.find_tweets('lincoln chafee').count

    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/democrats/webb' do
    @candidate = "Jim Webb"
    @tweets = Tweet.find_tweets('webb')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('webb').count
    @matches += Tweet.find_tweets('jim webb').count

    @total   = Tweet.count

    erb :election_tweets
  end

  #republicans

  get '/election/republicans/trump' do

    @candidate = "Donald Trump"
    @tweets = Tweet.find_tweets('trump')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('trump').count
    @matches += Tweet.find_tweets('donald trump').count
    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/republicans/carson' do
    @candidate = "Ben Carson"
    @tweets = Tweet.find_tweets('carson')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('carson').count
    @matches += Tweet.find_tweets('ben carson').count


    @total   = Tweet.count
    erb :election_tweets
  end

  get '/election/republicans/bush' do

    @candidate = "Jeb Bush"
    @tweets = Tweet.find_tweets('bush')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('bush').count
    @matches += Tweet.find_tweets('jeb bush').count
    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/republicans/cruz' do

    @candidate = "Ted Cruz"
    @tweets = Tweet.find_tweets('cruz')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('cruz').count
    @matches += Tweet.find_tweets('ted cruz').count
    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/republicans/rubio' do

    @candidate = "Marco Rubio"
    @tweets = Tweet.find_tweets('rubio')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('rubio').count
    @matches += Tweet.find_tweets('marco rubio').count
    @total   = Tweet.count

    erb :election_tweets
  end

  get '/election/republicans/walker' do

    @candidate = "Scott Walker"
    @tweets = Tweet.find_tweets('walker')
    @users = User.find_by_tweets(@tweets)
    @matches = 0
    @matches += Tweet.find_tweets('walker').count
    @matches += Tweet.find_tweets('scott walker').count
    @total   = Tweet.count

    erb :election_tweets
  end

end
