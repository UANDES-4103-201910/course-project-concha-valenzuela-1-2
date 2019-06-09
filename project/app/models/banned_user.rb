class BannedUser < ApplicationRecord
	belongs_to :user

	before_create :uniqueness_user

	def uniqueness_user
		for ban in BannedUser.all do
			if ban.user_id == user_id
				BannedUser.destroy(ban.id)
			end			
		end
	end


end
