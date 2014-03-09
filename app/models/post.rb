class Post < ActiveRecord::Base
	has_many :seen_post_trackers
	
	has_many :comments
	belongs_to :user
	validates :user_id, presence: true
	belongs_to :group
	validates :group_id, presence: true
	default_scope -> { order('created_at DESC') }
end
