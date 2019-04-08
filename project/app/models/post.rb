class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :dislikes
	has_many :inappropriate_content

	validates :title, presence: true, length: { maximum: 30, message: "The post's title should have no more than 30 characters." }
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :description, presence: true
	validates :close, inclusion: { in: [ true, false ], message: "It must be true or false" }
	validates :inappropriate, inclusion: { in: [ true, false ], message: "It must be true or false" }
	

	after_validation :innactive_user

	after_validation :default_unresolved, :on => :create

	after_validation :not_inappropriate, :on => :create

	after_update :notify_follower_update

	private def default_unresolved

		if unresolved == false
			errors.add(:close, "The Post must be unresolved when it's being created.")
		end

  	end

  	private def not_inappropriate

		if inappropriate == false
			errors.add(:inappropriate, "The Post must not be inappropriate when it's being created.")
		end

  	end

	private def innactive_user

		user = User.find(user_id)
		active = user[:active]

		if active == false
			errors.add(:user_id, "A User that is innactive cannot create a Post.")
		end
	end

	def notify_user(action)
		#n = Nofication.new(post_id: self.id, user_id: self.user_id, description: "commented")
		n = Notification.create(user_id: self[:user_id], post_id: self[:id], description: action)
	end

	def notify_follower(action)
		for follower in Follower.all
			if follower[:post_id] == self[:id]

				Notification.create(user_id: follower[:user_id], post_id: self[:id], description: action)
			end
		end
	end

	def notify_follower_update
		for follower in Follower.all
			if follower[:post_id] == self[:id]

				Notification.create(user_id: follower[:user_id], post_id: self[:id], description: "updated")
			end
		end
	end
end
