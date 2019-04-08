class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :dislikes
	has_many :inappropriate_content

	validates :title, presence: true, length: { maximum: 30, message: "The post's title should have no more than 30 characters." }
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :description, presence: true

	def private BelongsToUser

		u = User.find(user_id)

		if u == nil
			errors.add(:user_id, "You must use a correct User ID.")
		end

	end


	def private DefaultUnresolved

		u = User.find(user_id)

		if unresolved == false
			errors.add(:close, "The Post must be unresolved when it's being created.")
		end

  	end

	def private InnactiveUser

		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot create a Post.")
		end
	end

	def private NotInappropriate

		for post in InappropriateContent.all do
			if post[:id] == id
				errors.add(:id, "A Post cannot be created and belong to Inappropriate Content.")
			end
		end
	end

	def private NotDumpster

		for post in Dumpster.all do
			if post[:id] == id
				errors.add(:id, "A Post cannot be created and belong to Dumpster.")
			end
		end
	end

end
