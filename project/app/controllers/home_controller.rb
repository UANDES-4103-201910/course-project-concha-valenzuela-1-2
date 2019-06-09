class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, :only => [:index]
  
  def index
  	if current_user != nil && current_user.status == false
        for banned in BannedUser.all do 
          if current_user.id == banned.user_id
            if banned.created_at  <= 7.day.ago
              current_user.update(status: true)
              end
            end
        end
    end
  end
end
