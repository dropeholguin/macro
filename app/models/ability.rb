class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all

      can [:read, :count, :verify, :verify_card, :vote, :next_card], Question
      can :manage, Question, user_id: user.id
      can :show, User
      can :destroy, User, id: user.id
    end
  end
end
