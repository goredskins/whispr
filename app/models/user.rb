class User < ActiveRecord::Base
  has_many :comments  
  has_many :posts, dependent: :destroy
  has_many :memberships, foreign_key: "user_id", dependent: :destroy
  has_many :groups, through: :memberships, source: :group

  has_many :feed_items, through: :groups, source: :posts

  has_secure_password
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  #before_create :set_feed_last_view
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password,
  :presence => true,
  :confirmation => true,
  length: { minimum: 6 },
  :if => lambda{ new_record? || !password.nil? }

  has_attached_file :avatar, :styles => { :thumb => "150x150" }, :default_url => "/images/:style/missing.jpg"



  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(other_group)
    memberships.find_by(group_id: other_group.id)
  end

  def follow!(other_group)
    memberships.create!(group_id: other_group.id, last_view: Time.now)
  end

  def unfollow!(other_group)
    memberships.find_by(group_id: other_group.id).destroy!
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

end
