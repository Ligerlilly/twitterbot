class RemoveNotNullFromGeolatAndGeolong < ActiveRecord::Migration
  def change
    change_column :users, :geolat, :float
    change_column :users, :geolong, :float
  end
end
