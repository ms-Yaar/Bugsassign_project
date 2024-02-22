# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(user)
      user ||= User.new 
  
      if user.manager?
        can :manage, :all
      elsif user.qa?
        can :manage, Bug
        can :read, Project, user_id: user.id
        can [:read, :edit,:create], Bug,user_id: user.id
       
        

      elsif user.developer?
        
        #can [:read, :edit], Bug,user_id: user.id
    
        can :read, Project, user_id: user.id
        can :read, Bug
        can :edit, Bug
       # can :edit, Bug, user_id: user.id

      
       
      

      end
    end
  end
end
