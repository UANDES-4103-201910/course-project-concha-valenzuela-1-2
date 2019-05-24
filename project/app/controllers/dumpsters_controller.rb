class DumpstersController < ApplicationController

	def index
		@dumpsters = Dumpster.all
	end

	def create
		@post = Post.find(params[:post_id])
		@dumpster = Dumpster.create(post_id: @post.id)
		if @dumpster.save(post_id: @post.id)
	    	flash[:success] = "This post is now on the Dumpster."
	    	redirect_to dumpsters_path
	    else
	    	flash.now[:error] = "Cannot send this post to the Dumpster."
	    	render :index
	    end
		
	end

	def destroy
		@dumpster = Dumpster.find(params[:id])
  		@dumpster.destroy
  		if @dumpster.destroy
	      flash[:success] = "Successfully mark the post as Appropriate"
	      redirect_to posts_path
	    end
  	end

end
