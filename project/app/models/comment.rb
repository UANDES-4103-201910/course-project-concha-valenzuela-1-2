class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :description, presence: true

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :closed_post
	after_validation :innactive_user
	after_validation :dumpster_post

	after_create :notify_post

	private def closed_post

		post = Post.find(post_id)
		close = post[:close]

		if close == true
			errors.add(:post_id, "A closed post cannot be commented.")
		end
	end

	private def innactive_user

		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot comment a Post.")
		end
	end

	private def dumpster_post

		for post in Dumpster.all do

			if post[:post_id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be commented.")
			end
		end
			
	end

	private def notify_post

		post = Post.find(post_id)
		user = User.find(user_id)
		text = user[:name] + ' commented the post ' + post[:title] 
		post.notify_user(text)
		post.notify_follower(text)

	end




end
