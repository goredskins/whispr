class Comment < ActiveRecord::Base
	serialize :secondary_content, Array
	belongs_to :post
	validates :post_id, presence: true
	belongs_to :user
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 50 }
end
