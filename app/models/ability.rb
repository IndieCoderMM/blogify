# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all 

    return unless user.present?
    can :manage, Post, author: user
    can :manage, Comment, author: user 

    return unless user.role == 'admin'
    can :manage, :all
    
  end
end
