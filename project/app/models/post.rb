class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :dislikes
	has_many :inappropriate_contents
	has_many :notification_admins
	has_many :notification_super_admins
	has_many :notifications
	has_many :shares
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

 	has_attached_file :file
 	validates_attachment_content_type :file, content_type: "application/pdf"

	validates :title, presence: true, length: { maximum: 30, message: "The post's title should have no more than 30 characters." }
	validates :user_id, numericality: {message: "The User ID must be an integer."}
	validates :description, presence: true
	validates :close, inclusion: { in: [ true, false ], message: "It must be true or false" }
	validates :unresolved, inclusion: { in: [ true, false ], message: "It must be true or false" }
	validates :inappropriate, inclusion: { in: [ true, false ], message: "It must be true or false" }

	#after_validation :innactive_user
	after_validation :not_inappropriate, :on => :create

	after_create :create_user_profile
	after_create :create_geo

	after_update :update_geo
	after_update :notify_follower_update
	after_update :create_post_dumpster
	after_update :destroy_post_dumpster

	before_destroy :destroy_all_things


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
			status = user[:status]

			if status == false
				errors.add(:user_id, "A User that is innactive cannot create a Post.")
			end
		end
	end

	private def create_geo
		if gps != nil
			Geo.create(post_id: id, address: gps)
		end
		
	end

	private def update_geo
		if gps != nil
			geo = Geo.find_by(post_id: id)
			geo.update(address: gps)
		end
		
	end

	private def create_user_profile
		user = User.find(user_id)
		text = user[:name] +" created the post '" + title
		UserProfile.create(user_id: user_id, description: text, help: "post")
	end

	def self.search(title)
	  if title
	    where('title LIKE ? OR description Like ?', "%#{title}%", "%#{title}%")
	  else
	    all
	  end
	end

	def notify_user(action1, action2)
		n = Notification.create(user_id: self[:user_id], post_id: self[:id], description: action1, help: action2)
	end

	def notify_tag(action1, userid, action2)
		n = Notification.create(user_id: userid, post_id: self[:id], description: action1, help: action2)
	end


	def notify_follower(action1, action2)
		for follower in Follower.all
			if follower[:post_id] == self[:id]
				Notification.create(user_id: follower[:user_id], post_id: self[:id], description: action1, help: action2)
			end
		end
	end

	def notify_follower_update
		text = "The post '" + title + "' has been updated"
		for follower in Follower.all
			if follower[:post_id] == self[:id]
				Notification.create(user_id: follower[:user_id], post_id: self[:id], description: text, help:"update")
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
		for follower in Follower.all do
			if follower[:post_id] == id
				Follower.destroy(follower[:id])
			end
		end
		for share in Share.all do
			if share[:post_id] == id
				Share.destroy(share[:id])
			end
		end
		for wall in UserProfile.all do
			if wall[:post_id] == id
				UserProfile.destroy(wall[:id])
			end
		end
	end

end
