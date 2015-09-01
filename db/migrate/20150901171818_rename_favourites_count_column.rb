class RenameFavouritesCountColumn < ActiveRecord::Migration
  def change
    rename_column :users, :favourtes_count, :favourites_count
  end
end
