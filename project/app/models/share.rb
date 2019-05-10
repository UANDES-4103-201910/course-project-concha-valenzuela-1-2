class Share < ApplicationRecord
  	belongs_to :user
  	belongs_to :post

  	validates_associated :user
	validates_associated :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :innactive_user
	after_validation :dumpster_post
	after_validation :share_once

	after_create :notify_post
	after_create :create_user_profile

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
				errors.add(:user_id, "A User that is innactive cannot share a Post.")
			end
		end
	end

	private def dumpster_post

		for post in Dumpster.all do
			if post[:post_id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be dliked.")
			end
		end
	end

	private def share_once

		for share in Share.all
			if share[:post_id] == post_id && share[:user_id] == user_id
				errors.add(:post_id, "You have already shared the post")
			end
		end
	end

	private def create_user_profile
		post = Post.find(post_id)
		user = User.find(user_id)
		text = user[:name] +" shared the post '" + post[:title]+ "' at " + created_at.to_s
		UserProfile.create(user_id: user_id, description: text, help: "share")
	end

	private def notify_post
		user = User.find(user_id)
		post = Post.find(post_id)
		
		if post[:user_id] != user[:id]
			text = user[:name] + " shared the post '" + post[:title] + "' at " + created_at.to_s
			post.notify_user(text, "share")
		end
	end
end
