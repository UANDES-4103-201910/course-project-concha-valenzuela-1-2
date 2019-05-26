module SessionsHelper

	def log_in(user)
    	session[:user_id] = user.id
  	end

  	def current_user
      if session["warden.user.user.key"]
        current_user = User.find(session["warden.user.user.key"][0][0])
      end

    end




  	def logged_in?
	    !current_user.nil?
  	end
  	
  	def log_out
	    session.delete(:user_id)
	    @current_user = nil
  	end

  	def remember(user)
	    user.remember
	    cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token
  	end

  # Returns true if the given user is the current user.
  	def current_user?(user)
    	user == current_user
  	end

end
