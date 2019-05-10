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

	after_create :notify_admin

	private def innactive_user
		contador = 0
		for user in User.all
			if user[:id] == user_id
				contador = 1
			end
		end

		if contador == 1
			user = User.find(user_id)
			status = user[:status]

			if status == false
				errors.add(:user_id, "A User that is innactive cannot report a Post.")
			end
		end
	end

	private def dumpster_post

		for post in Dumpster.all do
			if post[:post_id] == post_id
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

	private def notify_admin

		post = Post.find(post_id)
		user = User.find(user_id)

		text = user[:name] + " reported '" + description + "' on the post '" + post[:title] + "' at " + created_at.to_s
		for user in User.all

			if user[:adm] == true || user[:super_adm] == true

				n = Notification.create(post_id: post[:id], description: text, user_id: user[:id], help: "inappropriate")
			end

		end

	end

end
