class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :likes, as: :commentable

  # Method to check if a comment is liked by a specific user
  def liked_by?(user)
    likes.exists?(user:)
  end
end
