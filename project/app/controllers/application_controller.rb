class ApplicationController < ActionController::Base

protect_from_forgery with: :exception
  include SessionsHelper

  def index

  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def is_user_logged_in?
      unless logged_in?
        flash[:error] = "Please log in."
        redirect_to root_url
      end
  end

end
