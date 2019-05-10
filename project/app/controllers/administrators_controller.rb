class AdministratorsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]



	def index
    	@admins = []

    	for user in User.all do 
    		if user.adm == true
    			@admins << user
    		end
    	end
  	end

	def show
		@admin = User.find(params[:id])
	end

	def new
		@admin = User.new
	end

	def edit
		@admin = User.find(params[:id])
	end

	def create
		@admin = User.new(user_params)

		if @admin.save(user_params)
	    	flash[:success] = "Successfully created."
	    	redirect_to @admin
	    else
	    	flash.now[:error] = "Cannot create this admin."
	    	render :new
	    end

	end

	def update
		@admin = User.find(params[:id])

		if @admin.update(user_params)
	      flash[:success] = "Successfully updated."
	      redirect_to @admin
	    else
	      flash[:error] = "Cannot update this admin."
	      render :edit
	    end
	end


	def destroy
		@admin = User.find(params[:id])
		@admin.destroy
		if @admin.destroy
	      flash[:success] = "Successfully destroyed."
	      redirect_to administrators_path
	    end
	end


	private 
		def set_user
    		@admin = User.find(params[:id])
    	end

  		def user_params

    		params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :birthdate, :country, :city, :gps, :picture, :terms, :aup, :biography).merge(adm: true)
  		end

  		def correct_user
      		@admin = User.find(params[:id])
      		redirect_to(root_url) unless @admin == current_user
    	end

    	def super_adm_user
    		redirect_to(root_url) unless current_user.super_adm?
    	end



end
