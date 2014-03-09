class AddFeedLastViewToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :feed_last_view, :datetime
  end
end
