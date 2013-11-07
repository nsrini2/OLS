class AddLeaveTypeToLeaves < ActiveRecord::Migration
  def change
      add_column :leaves, :leave_type, :string
      remove_column :leaves, :type
  end
end
