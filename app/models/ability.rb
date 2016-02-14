class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= nil
    if user.nil?
      can :read, :all
      cannot [:new, :create, :destroy, :edit, :update], Post
    else
      can :read, :all
      can :create, Post
      can [:update, :destroy], Post, :user_id => user.id
      can :create, Like
    end
  end
end
