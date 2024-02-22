class AddAssignedUserRoleToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :assigned_user_role, :string
  end
end
