class Blacklist < ApplicationRecord
 	belongs_to :user
 	
	validates :user_id, numericality: {message: "The User ID must be an integer."},
		uniqueness: {with: true, message: "The User is already on the Blacklist."}

	after_create :inactive_user
	after_create :create_banned_user

	after_destroy :active_user

	private def inactive_user
		for post in Post.all do

			if post[:user_id] == user_id

				if post[:inappropriate] == false

					Dumpster.create(post_id: post.id)
				end
			end
		end

		User.update(user_id, :status => false)

	end

	private def create_banned_user
		BannedUser.create(user_id: user_id)
	end

	private def active_user
		User.update(user_id, :status => true)

	end

	




end
