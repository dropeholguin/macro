class User < ApplicationRecord
has_many :badges , :through => :levels 
has_many :levels  

def change_points(options)
  if Gioco::Core::KINDS
    points = options[:points]
    kind   = Kind.find(options[:kind])
  else
    points = options
    kind   = false
  end

  if Gioco::Core::KINDS
    raise "Missing Kind Identifier argument" if !kind
    old_pontuation = self.points.where(:kind_id => kind.id).sum(:value)
  else
    old_pontuation = self.points.to_i
  end
  new_pontuation = old_pontuation + points
  Gioco::Core.sync_resource_by_points(self, new_pontuation, kind)
end

def next_badge?(kind_id = false)
  if Gioco::Core::KINDS
    raise "Missing Kind Identifier argument" if !kind_id
    old_pontuation = self.points.where(:kind_id => kind_id).sum(:value)
  else
    old_pontuation = self.points.to_i
  end
  next_badge       = Badge.where("points > #{old_pontuation}").order("points ASC").first
  last_badge_point = self.badges.last.try('points')
  last_badge_point ||= 0

  if next_badge
    percentage      = (old_pontuation - last_badge_point)*100/(next_badge.points - last_badge_point)
    points          = next_badge.points - old_pontuation
    next_badge_info = {
                        :badge      => next_badge,
                        :points     => points,
                        :percentage => percentage
                      }
  end
end
  rolify
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	 	:recoverable, :rememberable, :trackable, :validatable, :omniauthable

	validates :name, presence: true
	has_many :identities
	has_many :questions

	after_create :assign_default_role

	def assign_default_role
		self.add_role(:student) if self.roles.blank?
	end
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
