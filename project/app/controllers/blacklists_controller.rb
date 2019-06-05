class BlacklistsController < ApplicationController
	def index
		users = User.search(params[:search])
    	@blacklists = []

    	for user in users do 
    		if user.status == false 
    			@blacklists << user
    		end
    	end
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
  		@user = User.find(@blacklist.user_id)
  		@blacklist.destroy
  		if @blacklist.destroy
  		  #@user.update(status: true)
	      flash[:success] = "Successfully activated the user."
	      redirect_to users_path
	    end
	end
end
