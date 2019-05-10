class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :destroy]

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])
	    if user && user[:password] == params[:session][:password]
	      	log_in user
      		redirect_to root_url
      		Login.create(email: user[:email], password: user[:password])
	
	    else
	      	flash.now[:error] = "Invalid email/password combination."
	      	render 'new'
		end
	end

	def destroy
	    session.delete(:user_id)
	    @current_user = nil

	    redirect_to "http://localhost:3000/log_in"
	    
	end	

end
