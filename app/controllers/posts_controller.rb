class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new 
    @user = current_user
    @post = Post.new 
    # respond_to do |format|
    #   format.html { render: :new, locals: { post: post }}
  end

  def create 
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user
    if @post.save
      flash[:success] = "New post uploaded successfully!"
      redirect_to user_post_url(current_user, @post)
    else
      flash.now[:error] = "Post upload failed!"
      render :new 
    end
  end
end
