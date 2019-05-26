class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :destroy]

	def new
	end

	def create
		user = User.where(email: user_params[:email]).first
		puts user
		if user.valid_password?(user_params[:password])
	      # Save the user ID in the session so it can be used in
	      # subsequent requests
	      session[:current_user_id] = user.id
	      flash[:notice] = "Successful Login"
	      redirect_to user
	    else
	    	flash[:error] = "Invalid credentials"
	    	redirect_to root_url
	    end
	end

	def destroy
	    @current_user = session[:current_user_id] = nil
		session["warden.user.user.key"][0][0] = 0
    	redirect_to root_url
	    
	end	

	def user_params
      params.require(:session).permit(:email, :password)
    end

    def google_logged_in
      if session["warden.user.user.key"] then true else false end
    end

end
