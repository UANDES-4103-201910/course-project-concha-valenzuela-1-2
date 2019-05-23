class FollowersController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@follow = Follower.create(user_id: current_user.id, post_id: @post.id)
		redirect_to post_path(@post)
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @follow = Follower.find_by(user_id: current_user.id, post_id: @post.id)
	    @follow.destroy
	    redirect_to post_path(@post)	    
    end
end
