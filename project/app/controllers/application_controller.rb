class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:new, :create]
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include SessionsHelper

  def index
  end

  def authorize_admin
    redirect_to root_path unless current_user.adm
  end

  def authorize_super_admin
    redirect_to root_path unless current_user.super_adm
  end

  def is_user_logged_in?
      unless logged_in?
        flash[:error] = "Please log in."
        redirect_to root_url
      end
  end

  protected
	 def configure_permitted_parameters
	 	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :avatar, :terms, :aup, :biography, :city, :country, :gps, :birthdate])
	 	devise_parameter_sanitizer.permit(:account_update) do |u|
	      u.permit(:name, :email, :avatar, :terms, :aup, :biography, :city, :country, :gps, :birthdate, :password, :password_confirmation, :current_password)
	    end
	 end

end
