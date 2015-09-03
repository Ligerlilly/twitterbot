class Tweet < ActiveRecord::Base
  belongs_to :users

  def self.find_tweets(query)
    @results = []
    self.all.each do |tweet|
      tweet_string = tweet.tweet
      if tweet_string.include?(query)
        @results.push(tweet)
      end
    end
    @results
  end

  def self.find_by_user_id(user_id)
    found_tweet = ''
    self.all.each do |tweet|
      if tweet.user_id == user_id
        found_tweet = tweet.tweet
      end
    end
    found_tweet
  end

  def self.find_by_search(search_query, query)
    results = []
    count = 0
    self.all.each do |tweet|
      if tweet.search == search_query
        results.push(tweet)
      end
    end
    results.each do |r|
      if r.tweet.include?(query)
        count += 1
      end
    end
    count
  end

  before_save :tweet_downcase

private

  def tweet_downcase
    self.tweet = self.tweet.downcase
  end
end
