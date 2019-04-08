class Follower < ApplicationRecord
  	belongs_to :user
  	belongs_to :post

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}
	
	after_validation:follow_once

	after_create :notify_follow

	
	private def notify_follow
		post = Post.find(post_id)
		follower = User.find(user_id)
		text = follower[:name] + ' followed your post: ' + post[:title] 

		post.notify_user(text)
	end


	private def follow_once

		for follow in Follower.all
			if follow[:post_id] == post_id && follow[:user_id] == user_id
				errors.add(:post_id, "You have all ready followed the post")
			end
		end
	end


end
