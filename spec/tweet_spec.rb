require 'spec_helper'
#
describe User do
  before do
    @user = User.create({name: 'Jason', favourites_count: 234, followers_count: 18000, location: 'Portland, OR', geolat:  45.58776474, geolong: -122.75852075 })
    @tweet = Tweet.create({ tweet: 'HI THERE MISTER HOW ARE YOU', user_id: @user.id, search: 'election' })
  end
  describe '.find_tweets' do
    it 'should return a tweet based on a specific query' do
      expect(Tweet.find_tweets('mister how')).to eq [@tweet]
    end
  end

  describe '#tweet' do
    it "should return downcased tweet text" do
      expect(@tweet.tweet).to eq 'hi there mister how are you'
    end
  end

  describe '.find_by_user_id' do
    it 'should return tweets based on user ID' do
    expect(Tweet.find_by_user_id(@user.id)).to eq  'hi there mister how are you'
    end
  end

  describe '.find_by_search' do
    it 'should return all tweets found by query' do
      @tweets = Tweet.find_by_search('election')
      expect(@tweets.first.tweet).to eq 'hi there mister how are you'
    end
  end
end
