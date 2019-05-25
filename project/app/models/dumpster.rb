class Dumpster < ApplicationRecord
	belongs_to :post
	
	validates_associated :post

	validates :post_id, numericality: {message: "The Post ID must be an integer."},
		uniqueness: {with: true, message: "The Post is already on the Dumpster."}

	after_create :inappropriate_post

	after_destroy :appropriate_content

	private def inappropriate_post
		Post.update(post_id, :inappropriate => true)
	end

	private def appropriate_content
		Post.update(post_id, :inappropriate => false)
	end
end
