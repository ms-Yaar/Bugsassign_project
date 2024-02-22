class Project < ApplicationRecord
  belongs_to :user
  has_many :bugs
  
  
  
  attr_accessor :assigned_user_role

end
