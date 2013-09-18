class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :leave_ref_id
      t.int :requester_emp_id
      t.char :leave_type
      t.date :start_date
      t.date :end_date
      t.int :no_of_days
      t.text :request_remarks
      t.int :approver_emp_id
      t.char :status
      t.text :action_remarks
      t.text :admin_comments

      t.timestamps
    end
  end
end
