class PostsController < ApplicationController
  def new
    @post = Post.new

    return unless session[:draft_post].present?

    @post.body = session[:draft_post]
    session.delete(:draft_post)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

    return unless session[:draft_comment].present? && @post.id == session[:draft_comment][:post_id]

    @comment.body = session[:draft_comment][:body]
    session.delete(:draft_comment)
  end

  def create
    if current_user.nil?
      session[:draft_post] = post_params[:body]
      redirect_to new_user_session_path,
                  notice: 'Please sign in to continue.'
      return
    end

    if post_params[:body].blank?
      redirect_to new_post_path, notice: 'Post cannot be empty.'
      return
    end

    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.valid?
      @post.save
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def guard_user
  end
end
