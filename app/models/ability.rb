# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all 

    return unless user.present?
    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id

    return unless user.role == 'admin'
    can :manage, :all
    
  end
end
