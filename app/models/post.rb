class Post < ApplicationRecord
  validates :text, presence: true, length: { minimum: 1, maximum: 140 }
  has_many :comments
  belongs_to :user
end
