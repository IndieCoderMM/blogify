class CommentsController < ApplicationController
    def new 
        @user = current_user
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end

    def create 
        @post = Post.find(params[:post_id])
        @comment = Comment.new(params.require(:comment).permit(:text))
        @comment.author = current_user
        @comment.post = @post
        if @comment.save 
            flash[:success] = "New comment added successfully!"
            redirect_to user_post_url(@post.author, @post)
        else
            flash.now[:error] = "Comment upload failed!"
            render "new"
        end

    end
end
