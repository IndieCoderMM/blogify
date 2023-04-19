class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @current_user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'New post uploaded successfully!'
      redirect_to user_post_url(current_user, @post)
    else
      flash[:error] = 'Post upload failed! Please try again.'
      redirect_to new_user_post_url(current_user)
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    @post.destroy 

    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
