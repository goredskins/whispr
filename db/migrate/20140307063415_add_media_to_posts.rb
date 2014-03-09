class AddMediaToPosts < ActiveRecord::Migration
  def change
  	 add_column :posts, :media, :string
  	 add_column :posts, :media_type, :integer
  end
end
