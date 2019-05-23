class DislikesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@dislike = Dislike.create(user_id: current_user.id, post_id: @post.id)
		redirect_to post_path(@post)
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @dislike = Dislike.find_by(user_id: current_user.id, post_id: @post.id)
	    @dislike.destroy
	    redirect_to post_path(@post)	    
    end
end
