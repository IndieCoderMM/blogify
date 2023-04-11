class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @current = current_user
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user
    if @post.save
      flash[:success] = 'New post uploaded successfully!'
      redirect_to user_post_url(current_user, @post)
    else
      flash[:error] = 'Post upload failed! Please try again.'
      redirect_to new_user_post_url(current_user)
    end
  end
end
