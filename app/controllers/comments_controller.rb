class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    respond_to do |format|
      if @comment.save
        # Rendering view for html request
        format.html do
          flash[:success] = 'New comment added successfully!'
          redirect_to user_post_url(@post.author, @post)
        end
        # Rendering json for json request
        format.json { render json: @comment, status: :created }
      else
        format.html do
          flash[:error] = 'Comment upload failed!'
          redirect_to new_user_post_comment_url(@post.author, @post)
        end

        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_back_or_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
