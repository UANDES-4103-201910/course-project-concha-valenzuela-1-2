class User < ApplicationRecord
	has_many :comments
	has_many :posts
	has_many :likes
	has_many :dislikes
	has_many :notifications
	has_many :inappropriate_content
	has_one :user_profile
end
