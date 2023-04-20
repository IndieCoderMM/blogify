class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present?

    can :manage, User, id: user.id
    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id
    can :create, Like

    return unless user.role == 'admin'

    can :manage, :all
  end
end
