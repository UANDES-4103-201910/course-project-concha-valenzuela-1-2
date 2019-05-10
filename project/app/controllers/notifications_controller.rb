class NotificationsController < ApplicationController

	def index
		@notifications = []
		for n in Notification.all do 
			if current_user[:id] == n.user_id
				@notifications << n
			end
			
		end

	end

end
