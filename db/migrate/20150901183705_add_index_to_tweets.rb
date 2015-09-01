class AddIndexToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :tweet, unique: true
  end
end
