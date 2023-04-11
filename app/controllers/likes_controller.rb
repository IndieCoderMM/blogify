class LikesController < ApplicationController 
    def create 
        @post = Post.find(params[:post_id])
        @like = Like.new(author: current_user, post: @post)
        if @like.save 
            flash[:success] = "Gave a like to #{@post.title}!"
            redirect_to user_post_path(@post.author, @post)
        else
            flash[:error] = "Adding a like failed!"
            redirect_to user_post_path(@post.author, @post)
        end
    end
end