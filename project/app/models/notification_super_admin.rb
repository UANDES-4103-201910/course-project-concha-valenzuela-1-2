class NotificationSuperAdmin < ApplicationRecord
  	belongs_to :post

    validates :post_id, numericality: {message: "The Post ID must be an integer."}
	validates :description, presence: true

end
