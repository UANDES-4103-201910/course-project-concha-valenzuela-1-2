class RegistrationsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create]

	def new
    	@user = User.new	
	end

	def create
	    @user = User.new(registration_params)
	    if @user.save(registration_params)
	    	flash[:success] = "Successfully created."
	    	redirect_to root_url
	    else
	    	flash.now[:error] = "Cannot create this user."
	    	render :new
	    end
	end

	def terms_of_services
	end

	def aup
	end

	private
	    def registration_params
	      params.require(:registrations).permit(:name, :email, :password, :birthdate, :country, :city, :biography, :terms, :aup, :gps, :picture, :password_confirmation)
	    end

end