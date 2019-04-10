class Follower < ApplicationRecord
  	belongs_to :user
  	belongs_to :post

  	validates_associated :user
	validates_associated :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}
	
	after_validation :innactive_user
	after_validation :dumpster_post
	after_validation :follow_once
	after_validation :not_follow_yourself

	after_create :notify_follow

	private def innactive_user
		contador = 0
		for user in User.all
			if user[:id] == user_id
				contador = 1
			end
		end

		if contador == 1
			user = User.find(user_id)
			active = user[:active]

			if active == false
				errors.add(:user_id, "A User that is innactive cannot follw a Post.")
			end
		end
	end

	private def dumpster_post

		for post in Dumpster.all do
			if post[:id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be followed")
			end
		end			
	end
	
	private def notify_follow
		post = Post.find(post_id)
		follower = User.find(user_id)
		text = follower[:name] + " followed your post '" + post[:title] + "'"
		post.notify_user(text)
	end


	private def follow_once

		for follow in Follower.all
			if follow[:post_id] == post_id && follow[:user_id] == user_id
				errors.add(:post_id, "You have already followed the post")
			end
		end
	end

	private def not_follow_yourself
		
		contador = 0
		for post in Post.all
			if post[:id] == post_id
				contador = 1
			end
		end

		if contador == 1
			if user_id == Post.find(post_id)[:user_id]
				errors.add(:user_id, "You cannot follow your own Post.")
			end
		end
	end

end
