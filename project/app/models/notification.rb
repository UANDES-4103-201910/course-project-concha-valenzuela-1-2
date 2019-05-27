class Notification < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	before_create :uniqueness_notification

	def uniqueness_notification
		for noti in Notification.all do
			if noti.user_id == user_id && noti.description == description && noti.post_id == post_id
				Notification.destroy(noti.id)
			end			
		end
	end

end
