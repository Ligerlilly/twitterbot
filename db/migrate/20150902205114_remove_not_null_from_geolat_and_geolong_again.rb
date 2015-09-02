class RemoveNotNullFromGeolatAndGeolongAgain < ActiveRecord::Migration
  def change
    change_column :users, :geolat, :float, :null => true
    change_column :users, :geolong, :float, :null => true
  end
end
