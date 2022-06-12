class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  # validates :name, presence: true
  def self.find_for_github_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      # 名前を取得するときはこのように書く（今回はUserモデルにname属性がないのでエラーなる）
      # user.name = auth.info.name
      user.email = auth.info.email
      # 任意の20文字の文字列を作成する
      user.password = Devise.friendly_token[0, 20]
    end
  end
  # 最後に使います。
  def self.create_unique_string
    SecureRandom.uuid
  end
  has_many :posts
  has_many :comments
  has_one_attached :profile_picture
end
