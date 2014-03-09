class AddSecondaryContentToComments < ActiveRecord::Migration
  def change
  	 add_column :comments, :secondary_content, :text
  end
end
