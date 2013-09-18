class Employee < ActiveRecord::Base
  attr_accessible :address, :age, :desgination, :dob, :doj, :emp_id, :first_name, :last_name, :manager_emp_id, :manager_name, :mob_no, :off_email_id, :pan_no, :pers_email_id, :phone_no, :roles
has_many :leaves
has_many :subordinates, :class_name => "Employee", :foreign_key => "manager_emp_id"
belongs_to :manager, :class_name => "Employee"
end
