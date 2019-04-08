class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :description, presence: true

	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :post_id, numericality: {message: "The Post ID must be an integer."}

	def private BelongsToUser

		u = User.find(user_id)

		if u == nil
			errors.add(:user_id, "You must use a correct User ID.")
		end

	end

	def private BelongsToPost

		post = Post.find(post_id)

		if post == nil
			errors.add(:post_id, "You must use a correct Post ID.")
		end

	end

	def private ClosedPost

		post = Post.find(post_id)
		close = post[:close]

		if close == true
			errors.add(:post_id, "A closed post cannot be commented.")
		end
	end

	def private InnactiveUser

		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot comment a Post.")
		end
	end

	def private DumpsterPost

		for post in Dumpster.all do
			if post[:id] == post_id
				errors.add(:post_id, "A Post that is on the Dumpster cannot be commented.")
			end
		end
			
	end


end
