require 'spec_helper'
#
describe User do
  before do
    @user = User.create({name: 'Jason', favourites_count: 234, followers_count: 18000, location: 'Portland', geolat:  45.58776474, geolong: -122.75852075 })
  end

  describe '#name' do

    it 'should return the users name' do
      expect(@user.name).to eq 'Jason'
    end
  end
end
