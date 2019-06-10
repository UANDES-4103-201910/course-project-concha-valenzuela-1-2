class AbusiveContentsController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:new, :create]
	def new

	end
	def create

		NotifierMailer.send_email(ac_params[:description]).deliver
		redirect_to 'http://localhost:3000'
		
	end

	def ac_params
      params.require(:abusive_content).permit(:description)
    end
end
