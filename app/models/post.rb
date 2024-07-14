class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def liked_by?(user)
    user.likes.where(post_id: id).exists?
  end
end
