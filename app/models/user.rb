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

  has_many :posts
  has_many :comments
  has_one_attached :profile_picture
end
