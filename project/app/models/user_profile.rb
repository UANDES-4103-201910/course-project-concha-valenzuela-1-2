class UserProfile < ApplicationRecord
	belongs_to :user

	validates_associated :user

	validates :user_id, numericality: {message: "The Post ID must be an integer."}
	validates :description, presence: true



end
