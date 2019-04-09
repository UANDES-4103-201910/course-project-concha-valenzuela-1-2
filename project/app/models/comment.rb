class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates_associated :user
	validates_associated :post

	validates :description, presence: true
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	after_validation :closed_post
	after_validation :innactive_user
	after_validation :dumpster_post

	after_create :notify_post
	after_create :tag_a_user

	private def closed_post
		contador = 0
		for post in Post.all
			if post[:id] == post_id
				contador = 1
			end
		end

		if contador == 1

			post = Post.find(post_id)
			close = post[:close]

			if close == true
				errors.add(:post_id, "A closed post cannot be commented.")
			end
		end
	end

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
				errors.add(:user_id, "A User that is innactive cannot comment a Post.")
			end
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
		text = user[:name] + " commented '" + description + "' on the post: " + post[:title] 

		if (post[:user_id] != user[:id])
			post.notify_user(text)
		end


		post.notify_follower(text)

	end

	private def tag_a_user
		#Tag with @ and with "_" instead of space
		#Example: "Martin Concha" -> "@Martin_Concha"
		user = User.find(user_id)
		post = Post.find(post_id)
		words = description.split
		for i in words do
			if i["@"] == "@"
				use = i.delete "@"
				u = use.split("_")
				nameuser = ""
				for r in u do
					nameuser += r
					nameuser += " "
				end
				for us in User.all do
					if nameuser == (us[:name]+" ")
						text = user[:name] + " tag you on the post: "+ post[:title] 
						Notification.create(user_id: us[:id], post_id: post_id, description: text)
					end
				end
			end
		end
	end




end
