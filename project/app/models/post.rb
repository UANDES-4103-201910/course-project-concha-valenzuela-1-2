class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :dislikes
	has_many :inappropriate_content
	has_many :notification_admin
	has_many :notification_super_admin
	has_many :notification

	validates_associated :user

	validates :title, presence: true, length: { maximum: 30, message: "The post's title should have no more than 30 characters." }
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :description, presence: true
	validates :close, inclusion: { in: [ true, false ], message: "It must be true or false" }
	#validates :inappropriate, inclusion: { in: [ true, false ], message: "It must be true or false" }, :on => :update
	
	#validate :belongs_to_user
	after_validation :innactive_user
	after_create :default_unresolved, :on => :create
	after_validation :not_inappropriate, :on => :create

	after_update :notify_follower_update
	after_update :create_post_dumpster
	after_update :destroy_post_dumpster

	before_destroy :destroy_all_things


	private def default_unresolved
		#Post.update(id, :unresolved => true)

		if unresolved == false
			errors.add(:close, "The Post must be unresolved when it's being created.")
		end

  	end

  	private def not_inappropriate

		if inappropriate == true
			errors.add(:inappropriate, "The Post must not be inappropriate when it's being created.")
		end

  	end

	private def innactive_user

		contador = 0
		for user in User.all
			if user[:id] == user_id
				contador = 1
			end
		end

		if contador == 1
			user = User.find(user_id)
			active = user[:active]

			if active == false
				errors.add(:user_id, "A User that is innactive cannot create a Post.")
			end
		end
	end

	def notify_user(action)
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
		text = 'The post: ' + title + 'has been updated.'
		for follower in Follower.all
			if follower[:post_id] == self[:id]
				Notification.create(user_id: follower[:user_id], post_id: self[:id], description: text)
			end
		end
	end

	private def destroy_post_dumpster
		if inappropriate == false
			for post in Dumpster.all do
				if post[:post_id] == id
					Dumpster.destroy(post[:id])
				end
			end
		end
	end

	private def create_post_dumpster
		if inappropriate == true
			Dumpster.create(post_id: id)
		end
	end

	private def destroy_all_things
		for comment in Comment.all do
			if comment[:post_id] == id
				Comment.destroy(comment[:id])
			end
		end
		for like in Like.all do
			if like[:post_id] == id
				Like.destroy(like[:id])
			end
		end
		for dislike in Dislike.all do
			if dislike[:post_id] == id
				Dislike.destroy(dislike[:id])
			end
		end
		for inapp in InappropriateContent.all do
			if inapp[:post_id] == id
				InappropriateContent.destroy(inapp[:id])
			end
		end
		for dump in Dumpster.all do
			if dump[:post_id] == id
				Dumpster.destroy(dump[:id])
			end
		end
		for notification in Notification.all do
			if notification[:post_id] == id
				Notification.destroy(notification[:id])
			end
		end
		for notification in NotificationAdmin.all do
			if notification[:post_id] == id
				NotificationAdmin.destroy(notification[:id])
			end
		end
		
		for notification in NotificationSuperAdmin.all do
			if notification[:post_id] == id
				NotificationSuperAdmin.destroy(notification[:id])
			end
		end
		for follower in Follower.all do
			if follower[:post_id] == id
				Follower.destroy(follower[:id])
			end
		end
	end

end
