class FollowersController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@follow = Follower.create(user_id: current_user.id, post_id: @post.id)
    	flash[:success] = "You followed this post successfully."
    	redirect_to post_path(@post)
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @follow = Follower.find_by(user_id: current_user.id, post_id: @post.id)
	    @follow.destroy
	    if @follow.destroy
		    flash[:success] = "You no longer follow this post."
		    redirect_to post_path(@post)
	    end     
    end
end
