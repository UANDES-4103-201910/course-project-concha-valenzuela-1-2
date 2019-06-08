class AdministratorsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
	before_action :authorize_super_admin



	def index
    	admins = User.search(params[:search])
    	@administrators = []

    	for user in admins do 
    		if user.adm == true
    			@administrators << user
    		end
    	end
  	end

	def show
		@administrator = User.find(params[:id])
	end

	def new
		@administrator = User.new
	end

	def edit
		@administrator = User.find(params[:id])
	end

	def create
		@administrator = User.new(user_params)

		if @administrator.save(user_params)
	    	flash[:success] = "The admin was created successfully."
	    	redirect_to @administrator
	    else
	    	flash.now[:error] = "Cannot create this admin."
	    	render :new
	    end

	end

	def update
		@administrator = User.find(params[:id])

		if @administrator.update(user_params)
	      flash[:success] = "Successfully updated."
	      redirect_to @administrator
	    else
	      flash[:error] = "Cannot update this admin."
	      render :edit
	    end
	end


	def destroy
		@administrator = User.find(params[:id])
		@administrator.destroy
		if @administrator.destroy
	      flash[:success] = "The admin was destroyed successfully."
	      redirect_to administrators_path
	    end
	end


	private 
		def set_user
    		@administrator = User.find(params[:id])
    	end

  		def user_params

			if current_user == nil
    			params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :birthdate, :country, :city, :gps, :picture, :biography)
		  	else
    			params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :birthdate, :country, :city, :gps, :picture, :biography).merge(aup: true, terms: true, adm: true)
			end

  		end

  		def correct_user
      		@administrator = User.find(params[:id])
      		redirect_to(root_url) unless @administrator == current_user
    	end

    	def super_adm_user
    		redirect_to(root_url) unless current_user.super_adm?
    	end



end
