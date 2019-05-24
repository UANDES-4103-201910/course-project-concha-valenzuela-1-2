class LikesController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@like = Like.create(user_id: current_user.id, post_id: @post.id)
    	flash[:success] = "You liked this post successfully."
    	redirect_to post_path(@post)
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
	    @like.destroy
	    if @like.destroy
		    flash[:success] = "You no longer like this post."
		    redirect_to post_path(@post)
	    end 	    
    end
end
