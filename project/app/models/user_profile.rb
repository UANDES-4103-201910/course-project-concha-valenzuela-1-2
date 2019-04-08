class UserProfile < ApplicationRecord
	belongs_to :user

	validates :user_id, numericality: {message: "The Post ID must be an integer."}

end
