class Membership < ActiveRecord::Base
	belongs_to :user, class_name: "User"
	belongs_to :group, class_name: "Group"
	validates :user_id, presence: true
	validates :group_id, presence: true

	has_many :seen_post_trackers

	has_many :posts, through: :seen_post_trackers, source: :post
end
