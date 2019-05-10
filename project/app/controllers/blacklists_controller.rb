class BlacklistsController < ApplicationController
	def index
		@blacklists = Blacklist.all
	end

	def new
		@blacklist = Blacklist.new
	end

	def destroy
  		@blacklist = Blacklist.find(params[:id])
  		@blacklist.destroy
  		if @blacklist.destroy
	      flash[:success] = "Successfully activated the user."
	      redirect_to blacklists_path
	    end
	end
end
