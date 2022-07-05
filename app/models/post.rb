class Post < ApplicationRecord
  validates :text, presence: true, length: { minimum: 1, maximum: 140 }
  has_many :comments , dependent: :destroy
  has_many :likes, :as => :likable , dependent: :destroy
  belongs_to :user
end
