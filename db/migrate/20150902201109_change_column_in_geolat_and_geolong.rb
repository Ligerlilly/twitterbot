class ChangeColumnInGeolatAndGeolong < ActiveRecord::Migration
  def change
    change_column :users, :geolat, :float, :null => false
    change_column :users, :geolong, :float, :null => false
  end
end
