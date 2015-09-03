class AddSearchColumnToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :search, :string
  end
end
