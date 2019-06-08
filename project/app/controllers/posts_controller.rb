class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
	skip_before_action :authenticate_user!, :only => [:index, :show]
	def index
		posts = Post.search(params[:search])
		users = User.search(params[:search])
		@posts = []

		for post in posts do

			if post.inappropriate == false
				@posts << post
			end
		end
		for user in users do
			if user.status == true
				for post in Post.all do
					if post.inappropriate == false && post.user_id == user.id && @posts.exclude?(post)
						@posts << post
					end
				end
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
	 	if @post.save(post_params)
	    	flash[:success] = "The post was created successfully."
	    	redirect_to @post
	    else
	    	flash.now[:error] = "Cannot create this post."
	    	render :new
	    end
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
	      flash[:success] = "The post was updated successfully."
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
	      flash[:success] = "The post was destroyed successfully."
	      redirect_to posts_path
	    end
	end

	def innapropriate
	
		@inap = InappropriateContent.new

	end

	def map
		@post = Post.find(params[:post_id])
	end


	private
	  def post_params
	  	if current_user == nil
	  		params.require(:post).permit(:title, :description, :city, :country, :gps, :file, :avatar, :close, :user_id, :inappropriate, :unresolved)
	  	else
	    	params.require(:post).permit(:title, :description, :city, :country, :gps, :file, :avatar, :close, :user_id, :inappropriate, :unresolved).merge(user_id: current_user[:id])
		end

	  end
end
