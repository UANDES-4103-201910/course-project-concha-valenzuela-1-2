class SharesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@share = Share.create(user_id: current_user.id, post_id: @post.id)
    	flash[:success] = "You shared this post successfully."
    	redirect_to post_path(@post)
	end
end
