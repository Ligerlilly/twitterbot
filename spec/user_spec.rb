require 'spec_helper'
#
describe User do
  before do
    @user = User.create({name: 'Jason', favourites_count: 234, followers_count: 18000, location: 'Portland, OR', geolat:  45.58776474, geolong: -122.75852075 })
  end

  describe '#name' do
    it 'should return the users name' do
      expect(@user.name).to eq 'Jason'
    end
  end

  describe '#favourites_count' do
    it 'returns the count of the users favourites' do
      expect(@user.favourites_count).to eq 234
    end
  end

  describe '#followers_count' do
    it 'returns the count of the users followers' do
      expect(@user.followers_count).to eq 18000
    end
  end

  describe '#location' do
    it 'returns the city and state the user is located in' do
      expect(@user.location).to eq "Portland, OR"
    end
  end
end
