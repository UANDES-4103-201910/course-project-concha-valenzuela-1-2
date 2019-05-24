class BlacklistsController < ApplicationController
	def index
		@blacklists = Blacklist.all
	end

	def create
		@user = User.find(params[:user_id])
		@black = Blacklist.create(user_id: @user.id)
		if @black.save(user_id: @user.id)
	    	flash[:success] = "This user is now on the Blacklist."
	    	redirect_to blacklists_path
	    else
	    	flash.now[:error] = "Cannot send this user to the Blacklist."
	    	render :index
	    end
		
	end

	def destroy
  		@blacklist = Blacklist.find(params[:id])
  		@blacklist.destroy
  		if @blacklist.destroy
	      flash[:success] = "Successfully activated the user."
	      redirect_to users_path
	    end
	end
end
