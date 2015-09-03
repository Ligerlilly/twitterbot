class AddQueryToTweet < ActiveRecord::Migration
  def change
    add_column :users, :search, :string
  end
end
