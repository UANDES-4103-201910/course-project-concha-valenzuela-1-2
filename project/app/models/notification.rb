class Notification < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :dumpster_post

	private def dumpster_post

		for post in Dumpster.all do
			if post[:id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be notified.")
			end
		end
			
	end


end
