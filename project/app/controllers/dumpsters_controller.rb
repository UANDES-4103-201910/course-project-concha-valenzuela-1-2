class DumpstersController < ApplicationController

	def index
		@dumpsters = Dumpster.all
	end

	def destroy
		@dumpster = Dumpster.find(params[:id])
  		@dumpster.destroy
  		if @dumpster.destroy
	      flash[:success] = "Successfully mark the post as Appropriate"
	      redirect_to blacklists_path
	    end
  	end

end
