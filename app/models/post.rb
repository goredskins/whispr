class Post < ActiveRecord::Base
	has_many :seen_post_trackers

	has_attached_file :image, :styles => { :normal => "350x" }, :default_url => "/images/:style/missing.jpg"

	
	has_many :comments
	belongs_to :user
	validates :user_id, presence: true
	belongs_to :group
	validates :group_id, presence: true
	default_scope -> { order('created_at DESC') }
end
