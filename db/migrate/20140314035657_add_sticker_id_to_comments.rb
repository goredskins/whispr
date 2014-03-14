class AddStickerIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :sticker_id, :int
  end
end
