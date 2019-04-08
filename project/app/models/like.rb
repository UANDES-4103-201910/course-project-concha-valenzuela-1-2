class Like < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :innactive_user
	after_validation :dumpster_post

	private def innactive_user
		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot like a Post.")
		end
	end

	private def dumpster_post

		for post in Dumpster.all do
			if post[:id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be dliked.")
			end
		end
			
	end

	private def notify_post

		post = Post.find(post_id)
		post.notify_user("liked")

	end


end
