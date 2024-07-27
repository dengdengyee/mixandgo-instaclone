class Comments::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :set_post

  def create
    @like = @comment.likes.new(user: current_user)
    @like.save!
  end

  def destroy
    @like = @comment.likes.find_by(user: current_user)
    Like.delete_by(user: current_user, commentable_id: @comment.id, commentable_type: 'Comment')
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
