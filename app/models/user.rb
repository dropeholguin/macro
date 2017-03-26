class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	 	:recoverable, :rememberable, :trackable, :validatable, :omniauthable

	validates :name, presence: true
	has_many :identities
	has_many :questions

	def self.connect_to_linkedin(auth, signed_in_resource=nil)
	    user = User.joins(:identities).where("identities.provider = ? AND identities.uid = ?", auth.provider, auth.uid).first    

	    if user
	      return user
	    else
	      registered_user = User.where(email: auth.info.email).first
	      if registered_user
	        return registered_user
	      else
	        user = User.create(name: auth.info.first_name + " " + auth.info.last_name,
								email: auth.info.email,
								password: Devise.friendly_token[0,20],
							)
	        Identity.create_with_omniauth_linkedin(auth, user.id)

	        user
	      end
	    end
  	end 
end
