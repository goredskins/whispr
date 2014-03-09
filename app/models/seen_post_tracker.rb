class SeenPostTracker < ActiveRecord::Base
	belongs_to :membership, class_name: "Membership"
	belongs_to :post, class_name: "Post"
end
