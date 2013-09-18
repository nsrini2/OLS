class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :leave_ref_id
      t.integer :requester_emp_id
      t.string :leave_type
      t.date :start_date
      t.date :end_date
      t.integer :no_of_days
      t.text :request_remarks
      t.integer :approver_emp_id
      t.string :status
      t.text :action_remarks
      t.text :admin_comments

      t.timestamps
    end
  end
end
