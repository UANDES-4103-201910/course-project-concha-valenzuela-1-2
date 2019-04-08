class Dumpster < ApplicationRecord
	has_many :posts
	validates_associated :posts


	validates :post_id, numericality: {message: "The Post ID must be an integer."},
		uniqueness: {with: true, message: "The Post is already on the Dumpster."}
end
