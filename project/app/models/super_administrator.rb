class SuperAdministrator < ApplicationRecord

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

	validates :name, presence: true

	validates :password, length: { in: 8..12, 
		too_short: "The user passoword must have at least %{count} characters.",
		too_long: "The user password must have no more than %{count} characters."},
		format: {with: /\A[\sa-z0-9]+\Z/i, 
		message: "The password must be alphanumeric"},
		confirmation: true,
		presence: true


end
