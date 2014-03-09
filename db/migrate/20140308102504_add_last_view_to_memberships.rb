class AddLastViewToMemberships < ActiveRecord::Migration
  def change
  	add_column :memberships, :last_view, :datetime
  end
end
