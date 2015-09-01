require 'spec_helper'
#
describe User do
  before do
    @user = User.create({name: 'Jason', favourites_count: 234, followers_count: 18000, location: 'Portland, OR', geolat:  45.58776474, geolong: -122.75852075 })
    @tweet = Tweet.create({ tweet: 'HI THERE', user_id: @user.id })
  end
  describe '.find_tweets' do
    it 'should return a tweet based on a specific query' do
      expect(Tweet.find_tweets('hi')).to eq [@tweet]
    end
  end

  describe '#tweet' do
    it "should return downcased tweet text" do
      expect(@tweet.tweet).to eq 'hi there'
    end
  end
end
