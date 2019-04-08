class User < ApplicationRecord
	has_many :comments
	has_many :posts
	has_many :likes
	has_many :dislikes
	has_many :notifications
	has_many :inappropriate_content
	has_one :user_profile

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

	validates :name, presence: true

	validates :city, presence: true

	validates :country, presence: true

	validates :picture, presence: true

	validates :birthdate, presence: true

	validates :terms, acceptance: true

	validates :biography, length: { maximum: 100, message: "Your biography should have no more than 100 characters." }

	validates :password, length: { in: 8..12, 
		too_short: "The user passoword must have at least %{count} characters.",
		too_long: "The user password must have no more than %{count} characters."},
		format: {with: /\A[\sa-z0-9]+\Z/i, 
		message: "The password must be alphanumeric"},
		confirmation: true

	def private ActiveTrue
		if active == false
			errors. add(:active, "must be true when the account is being created.")
		end
	end



end
