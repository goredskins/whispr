class CreateSeenPostTrackers < ActiveRecord::Migration
  def change
    create_table :seen_post_trackers do |t|
      t.integer :membership_id
      t.integer :post_id

      t.timestamps
    end
  end
end
