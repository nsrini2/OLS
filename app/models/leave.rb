class Leave < ActiveRecord::Base
  attr_accessible :action_remarks, :admin_comments, :approver_emp_id, :end_date, :ref_id, :leave_type, :no_of_days, :request_remarks, :requester_emp_id, :start_date, :status, :request_remarks,:request_date, :action

validates_presence_of :requester_emp_id
validates_presence_of :leave_type
validates_presence_of :start_date, :end_date, :no_of_days
validates_presence_of :action

validates_numericality_of :requester_emp_id, :only_integer => true, :message => "Please input a valid entry for requester emp id"
#validates_numericality_of :approver_emp_id, :only_integer => true, :message => "Please enter a whole number for approver emp id"
validates_numericality_of :no_of_days, :only_integer => true, :message => "Please enter a whole no for no. of days of leave"
validates_date :start_date, :end_date

belongs_to :employee, :foreign_key => 'employee_id'
end
