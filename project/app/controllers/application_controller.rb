class ApplicationController < ActionController::Base
before_action :authenticate_user!
protect_from_forgery with: :exception
  include SessionsHelper

  def index

  end



  def is_user_logged_in?
      unless logged_in?
        flash[:error] = "Please log in."
        redirect_to root_url
      end
  end

end
