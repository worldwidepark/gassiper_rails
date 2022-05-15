class Post < ApplicationRecord
  validates :text, length: { minimum: 1, maximum: 140 }
end
