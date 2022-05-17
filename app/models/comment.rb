class Comment < ApplicationRecord
  validates :text, length: { minimum: 1, maximum: 140 }
  belongs_to :user
  belongs_to :post
end
