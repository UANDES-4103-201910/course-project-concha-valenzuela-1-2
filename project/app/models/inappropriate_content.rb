class InappropriateContent < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates_associated :user
	validates_associated :post

	validates :description, presence: true
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :innactive_user
	after_validation :dumpster_post
	after_validation :report_once

	private def innactive_user

		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot report a Post.")
		end
	end

	private def dumpster_post

		for post in Dumpster.all do
			if post[:id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be reported.")
			end
		end
			
	end

	private def report_once

		for report in InappropriateContent.all
			if report[:post_id] == post_id && report[:user_id] == user_id
				errors.add(:post_id, "You have already reported the post")
			end
		end
	end
end
