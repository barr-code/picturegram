class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= nil
    if user.nil?
      can :read, :all
      cannot [:new, :create, :destroy, :edit, :update], Post
    end
  end
end