class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post
    if @comment.save
      flash[:success] = 'New comment added successfully!'
      redirect_to user_post_url(@post.author, @post)
    else
      flash[:error] = 'Comment upload failed!'
      redirect_to new_user_post_comment_url(@post.author, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
