class AddTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.column :tweet, :string, unique: true

      t.timestamps
    end
  end
end
