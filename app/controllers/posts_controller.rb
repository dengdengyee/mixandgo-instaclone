class PostsController < ApplicationController
  def new
    @post = Post.new
    return if session[:draft_post].nil?

    @post.body = session[:draft_post]
    session.delete(:draft_post)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    if current_user.nil?
      session[:draft_post] = post_params[:body]
      redirect_to new_user_session_path,
                  notice: 'Please sign in to continue.'
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
