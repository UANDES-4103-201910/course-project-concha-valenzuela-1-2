class User < ApplicationRecord
	has_many :comments
	has_many :posts
	has_many :likes
	has_many :dislikes
	has_many :notifications
	has_many :inappropriate_content
	has_one :user_profile

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

	validates :name, presence: true

	validates :city, presence: true

	validates :country, presence: true

	validates :picture, presence: true

	validates :birthdate, presence: 
	validate do
      self.errors[:birthdate] << "must be a valid date" unless (DateTime.parse(self.birthdate) rescue false)
   	end

	validates :terms, inclusion: { in: [ true ], message: "It must be true" }

	validates :biography, length: { maximum: 100, message: "Your biography should have no more than 100 characters." },
		presence: true

	validates :password, length: { in: 8..12, 
		too_short: "The user passoword must have at least %{count} characters.",
		too_long: "The user password must have no more than %{count} characters."},
		format: {with: /\A[\sa-z0-9]+\Z/i, 
		message: "The password must be alphanumeric"},
		confirmation: true,
		presence: true

	after_validation :born_before_today
	after_validation :active_true, :on => :create

	private def active_true

		if active == false
			errors.add(:active, "must be true when the account is being created.")
			
		end
	end

	private def born_before_today

		return if birthdate.blank?

		if Date.today < birthdate
			errors.add(:birthdate, "The birthdate must be before today's date.")
		
		end

	end

end
