# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    user ||= User.new # guest user (not logged in)

    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :admin
      can :manage, Store, id: user.store_id
      can :manage, User, store_id: user.store_id
      can :manage, Customer, store_id: user.store_id
      can :manage, Product, store_id: user.store_id
      can :manage, Invoice, store_id: user.store_id
      can :manage, Payment, store_id: user.store_id
      can :read, Role
    elsif user.has_role? :store_manager
      can :manage, Customer, store_id: user.store_id
      can [:create, :read], Invoice, store_id: user.store_id
      can :read, Product, store_id: user.store_id
    else
      # Define permissions for regular users or guests here
    end
  end
end
