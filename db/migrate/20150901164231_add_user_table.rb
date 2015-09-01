class AddUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :name,            :string, unique: true
      t.column :favourtes_count, :integer
      t.column :followers_count, :integer
      t.column :location,        :string
      t.column :geolat,          :float
      t.column :geolong,         :float

      t.timestamps
    end
  end
end
