class Identity < ApplicationRecord
	belongs_to :user
  	validates_presence_of :uid, :provider

  	def self.find_with_omniauth(auth)
		find_by(uid: auth.uid, provider: auth.provider)
	end

	def self.create_with_omniauth_linkedin(auth, user_id)
		create(user_id: user_id, uid: auth.uid, provider: auth.provider)
	end
end
