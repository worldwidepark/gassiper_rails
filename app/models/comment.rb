class Comment < ApplicationRecord
  validates :text, presence: true, length: { minimum: 1, maximum: 140 }
  belongs_to :user
  belongs_to :post
  has_many :likes, :as => :likable
end
