class AddCommentableToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :commentable, polymorphic: true, index: true, null: true
  end
end
