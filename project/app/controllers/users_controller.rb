class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
	before_action :set_user, only: [:edit, :update, :destroy, :show]


	def index
		users = User.search(params[:search])
    	@users = []

    	for user in users do 
    		if user.status == true && user.adm == false
    			@users << user
    		end
    	end
  	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save(user_params)
	    	flash[:success] = "Successfully created."
	    	redirect_to @user
	    else
	    	flash.now[:error] = "Cannot create this user."
	    	render :new
	    end

	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
	      flash[:success] = "Successfully updated."
	      redirect_to @user
	    else
	      flash[:error] = "Cannot update this user."
	      render :edit
	    end
	end


	def destroy
		@user = User.find(params[:id])
		@user.destroy
		if @user.destroy
	      flash[:success] = "The user was destroyed successfully."
	      redirect_to users_path
	    end
	end


	private 
		def set_user
    		@user = User.find(params[:id])
    	end

  		def user_params
    		params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthdate, :country, :city, :gps, :terms, :aup, :biography, :avatar).merge(aup: true, terms: true)
  		end

  		def correct_user
      		@user = User.find(params[:id])
      		redirect_to(root_url) unless @user == current_user
    	end

    	def adm_user
    		redirect_to(root_url) unless current_user.adm?
    	end


end
