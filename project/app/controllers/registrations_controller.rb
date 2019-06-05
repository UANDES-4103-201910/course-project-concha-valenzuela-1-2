class RegistrationsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create]
	skip_before_action :authenticate_user!, :only => [:terms_of_services, :aup]

	def new
    	@user = User.new	
	end

	def create
	    @user = User.new(registration_params)
	    if @user.save(registration_params)
	    	flash[:success] = "The user was created successfully."
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
	      params.require(:registrations).permit(:name, :email, :password, :birthdate, :country, :city, :biography, :terms, :aup, :gps, :avatar, :password_confirmation)
	    end

end
