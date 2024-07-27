class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  def liked_by?(user)
    user.likes.where(commentable_id: id).exists?
  end
end
