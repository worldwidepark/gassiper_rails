class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  validates :name, presence: true

  def self.find_for_github_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def liked(post_or_comment)
    post_or_comment.likes.find_by(user_id: self.id)
  end

  def follow(want_follow_user_id)
    self.follows.new(followed_id: want_follow_user_id).save
  end


  def unfollow(want_unfollow_user_id)
    self.follows.find_by(followed_id: want_unfollow_user_id).delete
  end

  def is_following(user_id)
    self.follows.find_by(followed_id: user_id).present?
  end

  has_many :posts
  has_many :comments
  has_one_attached :profile_picture
  has_many :likes
  has_many :follows, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :follows, source: :followed
  has_many :followers, through: :follows
end
