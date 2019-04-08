class Blacklist < ApplicationRecord
 	has_many :users
 	validates_associated :users
	validates :user_id, numericality: {message: "The User ID must be an integer."},
		uniqueness: {with: true, message: "The User is already on the Blacklist."}

	after_create :inactive_user

	private def inactive_user
		User.update(user_id, :active => false)
	end

	private def posts_to_dumpster
		for post in Post.all do
			if post[:user_id] == user_id
				for inapp in InappropriateContent.all do
					if inapp[:post_id] == post[:id]
						contador += 1
					end
				end
				if contador >= 3
					Dumpster.create(post_id: post[:id])
				end
			end
		end
	end




end
