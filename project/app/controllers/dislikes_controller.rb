class DislikesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@dislike = Dislike.create(user_id: current_user.id, post_id: @post.id)
    	flash[:success] = "You disliked this post successfully."
    	redirect_to post_path(@post)
	end

	def destroy
	    @post = Post.find(params[:post_id])
	    @dislike = Dislike.find_by(user_id: current_user.id, post_id: @post.id)
	    @dislike.destroy
	    if @dislike.destroy
		    flash[:success] = "You no longer dislike this post."
		    redirect_to post_path(@post)
	    end    
    end
end
