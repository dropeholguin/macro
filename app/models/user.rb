class User < ApplicationRecord
  acts_as_token_authenticatable
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :trackable, :validatable, :omniauthable, :confirmable, :lockable

  has_many :identities
  has_many :questions
  has_many :badges, through: :levels 
  has_many :levels
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_many :cards
  has_many :comments
  has_many :flags, dependent: :destroy
  has_many :sessions
  has_many :session_cards
  has_many :stats_sessions
  has_many :notifications

  after_create :assign_default_role

  has_reputation :votes, source: {reputation: :votes, of: :questions}, aggregated_by: :sum
  has_reputation :votes, source: {reputation: :votes, of: :comments}, aggregated_by: :sum
  scope :users_with_less_of_eight_cards, -> {where('points < ?', 8)}

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

	def assign_default_role
		self.add_role(:student) if self.roles.blank?
    self.change_points(8) if self.points.blank?
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
        user = User.new(name: auth.info.first_name + " " + auth.info.last_name,
							email: auth.info.email,
							password: Devise.friendly_token[0,20],
						)
        user.skip_confirmation!
        user.save!
        Identity.create_with_omniauth_linkedin(auth, user.id)
        user
      end
    end
	end

  def voted_for?(question)
    evaluations.where(target_type: question.class, target_id: question.id).present?
  end

  def self.from_omniauth(auth)
    identity = Identity.where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize
    user = nil

    if identity.user.blank?
      email = auth.info.email ? auth.info.email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      user = where('email = ?', email).first_or_initialize do |user|
        user.name     = auth.info.name
        user.email    = email
        user.password = Devise.friendly_token[0,20]
      end
      user.identities << identity
    else
      user = identity.user
    end

    user.skip_confirmation!
    user.save!
    user
  end

  # instead of deleting user, replace user details & timestamp action
  def soft_delete
    self.transaction do
      self.identities.destroy_all
      self.update(
        email: "#{TEMP_EMAIL_PREFIX}-#{(Time.now.to_f * 100000).to_i}-sasensei.com",
        name: self.id,
        username: self.id,
        deleted_at: Time.current
      )
    end
  end
  
  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end
  
  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
