class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
	def index
		@posts = []

		for post in Post.all do

			if post.inappropriate == false
				@posts << post
			end
		end

	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def edit
		@post = Post.find(params[:id])
	end


	def create
		@post = Post.new(post_params)
		#@post.update(:user_id => current_user[:id])
	 	if @post.save(post_params)
	    	flash[:success] = "Successfully created."
	    	redirect_to @post
	    else
	    	flash.now[:error] = "Cannot create this post."
	    	render :new
	    end
	end

	def update

		@post = Post.find(params[:id])
		if @post.update(post_params)
	      flash[:success] = "Successfully updated."
	      redirect_to @post
	    else
	      flash[:error] = "Cannot update this post."
	      render :edit
	    end
	end


	def destroy
  		@post = Post.find(params[:id])
  		@post.destroy
  		if @post.destroy
	      flash[:success] = "Successfully destroyed."
	      redirect_to posts_path
	    end
	end

	def innapropriate
	
		@inap = InappropriateContent.new

	end



	private
	  def post_params
	  	if current_user == nil
	  		params.require(:post).permit(:title, :description, :city, :country, :gps, :file, :images, :close, :user_id, :inappropriate, :unresolved)
	  	else
	    	params.require(:post).permit(:title, :description, :city, :country, :gps, :file, :images, :close, :user_id, :inappropriate, :unresolved).merge(user_id: current_user[:id])
		end

	  end
end
