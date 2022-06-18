class Post < ApplicationRecord
  validates :text, presence: true, length: { minimum: 1, maximum: 140 }
  has_many :comments
  has_many :likes, :as => :likable
  belongs_to :user
end
