class CommentsController < ApplicationController
  before_action :validate_user, only: %i[create]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])

    if comment_params[:body].blank?
      render :new, status: :unprocessable_entity
      return
    end

    comment = Comment.new(comment_params)
    comment.post = @post
    comment.user = current_user

    if comment.save
      render :new, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def validate_user
    unless user_signed_in?
      redirect_to new_user_session_path,
                  alert: 'Please sign in to continue.'
      return
    end

    body = comment_params[:body]

    if body.blank?
      redirect_to new_post_comment_path(post_id: params[:post_id])
      return
    end

    session[:draft_comment] = {
      post_id: params[:post_id],
      body:
    }
  end
end
