class Login < ApplicationRecord

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, 
		presence: true
	validates :password, length: { in: 8..12, 
		too_short: "The user passoword must have at least %{count} characters.",
		too_long: "The user password must have no more than %{count} characters."},
		format: {with: /\A[\sa-z0-9]+\Z/i, 
		message: "The password must be alphanumeric"},
		presence: true

	after_validation :valid_login
	

	private def valid_login

		contador = 0
		for user in User.all
			if user[:email] == email && user[:password] == password
				contador = 1
			end
		end

		for admin in Administrator.all
			if admin[:email] == email && admin[:password] == password
				contador = 1
			end
		end

		for sadmin in SuperAdministrator.all
			if sadmin[:email] == email && sadmin[:password] == password
				contador = 1			
			end
		end

		if contador == 0
			errors.add(:email, "The email or the password is not valid.") 
		end
	end
end
