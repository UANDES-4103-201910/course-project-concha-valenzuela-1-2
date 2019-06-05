class User < ApplicationRecord	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
	has_many :comments, :dependent => :destroy
	has_many :posts, :dependent => :destroy
	has_many :likes, :dependent => :destroy
	has_many :dislikes, :dependent => :destroy
	has_many :notifications, :dependent => :destroy
	has_many :inappropriate_contents, :dependent => :destroy
	has_many :user_profiles, :dependent => :destroy
	has_many :notifications, :dependent => :destroy
	has_many :shares, :dependent => :destroy
	has_attached_file :avatar, styles: { medium: "240x240>", thumb: "50x50>"}, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true
	validates :name, uniqueness: true, presence: true

	validates :terms, inclusion: { in: [ true ], message: "It must be true" }
	validates :aup, inclusion: { in: [ true ], message: "It must be true" }
	validates :biography, length: { maximum: 100, message: "Your biography should have no more than 100 characters." }
	#validates :password, length: { in: 5..12, 
	#	too_short: " must have at least %{count} characters.",
	#	too_long: " must have no more than %{count} characters."},
	#	confirmation: true,
	#	presence: true

	after_validation :born_before_today
	
	after_update :active_user
	after_update :inactive_user

	before_destroy :destroy_all_things

  	def self.from_omniauth(auth)
		where(provider: auth.provider ,uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
			user.name = auth.info.name
			user.terms = true
			user.aup = true
			user.password = Devise.friendly_token[0, 20]
		end
	end


	private def born_before_today

		return if birthdate.blank?

		if Date.today < birthdate
			errors.add(:birthdate, "The birthdate must be before today's date.")
		end
	end

	private def active_user
		if status == true
			for black in Blacklist.all do
				if black[:user_id] == id
					Blacklist.destroy(black[:id])
				end
			end
		end
	end

	def self.search(name)
	  if name
	    where('name LIKE ? OR city LIKE ?', "%#{name}%", "%#{name}%")
	  else
	    all
	  end
	end

	private def inactive_user
		if status == false
			cont = 0
			for black in Blacklist.all
				if black.user_id == id
					cont = 1

				end
			end

			if cont == 0
				Blacklist.create(user_id: id)
			end

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
		for share in Share.all do
			if share[:user_id] == id
				Share.destroy(share[:id])
			end
		end
		for wall in UserProfile.all do
			if wall[:user_id] == id
				UserProfile.destroy(wall[:id])
			end
		end
	end

end
