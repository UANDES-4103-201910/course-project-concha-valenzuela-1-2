class UserProfile < ApplicationRecord
	belongs_to :user

	validates :user_id, numericality: {message: "The Post ID must be an integer."}
	validates :description, presence: true

	before_create :uniqueness_wall

	def uniqueness_wall
		for wall in UserProfile.all do
			if wall.user_id == user_id && wall.description == description
				UserProfile.destroy(wall.id)
			end			
		end
	end

end
