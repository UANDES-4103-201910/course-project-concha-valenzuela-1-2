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
	after_create :create_user_profile

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
			status = user[:status]

			if status == false
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

	private def create_user_profile
		post = Post.find(post_id)
		user = User.find(user_id)
		d = ""
        contador = 0
        for i in description.split('')
        	d << i
            contador += 1
            if contador == 20
            	d += '...'
            	break 
          	end
        end
		text = user[:name] +" commented '" + d + "' on the post '" + post[:title]

		UserProfile.create(user_id: user_id, description: text, help: "comment")
	end



	private def notify_post

		post = Post.find(post_id)
		user = User.find(user_id)
		d = ""
        contador = 0
        for i in description.split('')
        	d << i
            contador += 1
            if contador == 20
            	d += '...'
            	break 
          	end
        end
		text2 = user[:name] + " commented '" + d + "' on the post '" + post[:title]
		
		if post[:user_id] == user[:id]
		else
			post.notify_user(text2, "comment")
		end
		post.notify_follower(text2, "comment")

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
						text = user[:name] + " tagged you on the post '"+ post[:title]
						post.notify_tag(text, us[:id], "tag")
					end
				end
			end
		end
	end

end
