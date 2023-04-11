class LikesController < ApplicationController 
    def create 
        @post = Post.find(params[:post_id])
        @like = Like.new(author: current_user, post: @post)
        if @like.save 
            flash[:success] = "Added a like to #{@post.name}!"
        else
            flash.now[:error] = "Adding a like failed!"
        end
    end
end