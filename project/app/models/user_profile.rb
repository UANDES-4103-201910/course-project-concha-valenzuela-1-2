class UserProfile < ApplicationRecord
	belongs_to :user

	validates :user_id, numericality: {message: "The Post ID must be an integer."}

	def private BelongsToUser

		u = User.find(user_id)

		if u == nil
			errors.add(:user_id, "You must use a correct User ID.")
		end

	end
end
