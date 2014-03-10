class Group < ActiveRecord::Base
	has_many :reverse_memberships, foreign_key: "group_id",
                                   class_name:  "Membership",
                                   dependent:   :destroy
    has_many :users, through: :reverse_memberships, source: :user
   	has_many :posts
   	has_many :comments, through: :posts

   	validates :name,
  	:presence => true,
  	length: { minimum: 1 }

end
