class Post < ApplicationRecord
  validates :text, presence: true, length: { minimum: 1, maximum: 140 }
  validates :user_id, presence: true
  has_many :comments , dependent: :destroy
  has_many :likes, :as => :likable , dependent: :destroy
  belongs_to :user
end
