class AbusiveContentsController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:new, :create]
	def new

	end
	def create

		NotifierMailer.send_email(ac_params[:description], ac_params[:email]).deliver
		flash[:success] = "The report was successfully send"
		redirect_to 'http://localhost:3000'
		
	end

	def ac_params
      params.require(:abusive_content).permit(:description, :email)
    end
end
