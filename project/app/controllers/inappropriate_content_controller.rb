class InappropriateContentController < ApplicationController
	def new
		@inap = InappropriateContent.new
	end

	def create
		@inap = InappropriateContent.new(inap_params)
	 	if @inap.save(inap_params)
	    	flash[:success] = "Successfully created."
	    	redirect_to posts_path
	    else
	    	flash.now[:error] = "Cannot create this content."
	    	render :new
	    end
	end

	private
	  def inap_params
   		params.require(:inap).permit(:description).merge(user_id: current_user.id, post_id: params[:post_id])
    end

end
