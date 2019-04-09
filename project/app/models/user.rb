class User < ApplicationRecord	
	has_many :comments
	has_many :posts
	has_many :likes
	has_many :dislikes
	has_many :notifications
	has_many :inappropriate_contents
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

	after_create :create_profile

	after_update :active_user
	after_update :inactive_user

	before_destroy :destroy_all_things

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

	private def active_user
		if active == true
			for black in Blacklist.all do
				if black[:user_id] == id
					Blacklist.destoy(black[:id])
				end
			end
		end
	end

	private def inactive_user
		if active == false
			Blacklist.create(user_id: id)
		end
	end

	private def destroy_all_things
		for follower in Follower.all do
			if follower[:user_id] == id
				Follower.destroy(follower[:id])
			end
		end
		for profile in UserProfile.all do
			if profile[:user_id] == id
				UserProfile.destroy(profile[:id])
			end
		end
		for comment in Comment.all do
			if comment[:user_id] == id
				Comment.destroy(comment[:id])
			end
		end
		for like in Like.all do
			if like[:user_id] == id
				Like.destroy(like[:id])
			end
		end
		for dislike in Dislike.all do
			if dislike[:user_id] == id
				Dislike.destroy(dislike[:id])
			end
		end
		for inapp in InappropriateContent.all do
			if inapp[:user_id] == id
				InappropriateContent.destroy(inapp[:id])
			end
		end
		for black in Blacklist.all do
			if black[:user_id] == id
				Blacklist.destroy(black[:id])
			end
		end
		for notification in Notification.all do
			if notification[:user_id] == id
				Notification.destroy(notification[:id])
			end
		end
	end

	private def create_profile
		UserProfile.create(user_id: id)
	end

end
