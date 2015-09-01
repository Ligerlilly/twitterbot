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

  before_save :tweet_downcase

private

  def tweet_downcase
    self.tweet = self.tweet.downcase
  end
end
