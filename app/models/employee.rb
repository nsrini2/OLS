require 'role_access'

class Employee < ActiveRecord::Base
include RoleAccess
  attr_accessible :local_addr, :perm_addr, :age, :designation, :dob, :doj, :emp_id, :first_name, :last_name, :manager_emp_id, :manager_name, :mob_no, :off_email_id, :pan_no, :pers_email_id, :phone_no, :gender, :roles
attr_accessible :leaves_attributes

#attr_protected :roles

validate :dates_cannot_be_in_the_future
validates_presence_of :local_addr, :message => "Local address cannot be blank"
validates_presence_of :perm_addr, :message => "Permanent address cannot be blank"
validates_presence_of :age, :message => "Unable to calculate employee's age at joining; please enter employee dob correctly.."
validates_presence_of :designation, :message => "Employee's designation at RapidThink cannot be blank"
validates_presence_of :dob, :message => "Employee's date of birth cannot be blank"
validates_presence_of :doj, :message => "Employee's date of joining RapidThink cannot be blank"
validates_presence_of :emp_id, :message => "Emp Id cannot be blank"
validates_presence_of :first_name, :message => "Employee's first name cannot be blank"
validates_presence_of :last_name, :message => "Employee's last name cannot be blank"
validates_presence_of :manager_emp_id, :message => "Employee's manager id cannot be blank"
validates_presence_of :manager_name, :message => "Employee's manager name cannot be blank"
validates_presence_of :mob_no, :message => "Employee's mobile number cannot be blank"
validates_presence_of :off_email_id, :message => "Employee's RapidThink email id cannot be blank"
validates_presence_of :pan_no, :message => "Employee's PAN number cannot be blank"
validates_presence_of :pers_email_id, :message => "Employee's personal email id cannot be blank"
validates_presence_of :phone_no, :message => "Employee's permanent phone no cannot be blank"
validates_presence_of :roles, :message => "Employee roles cannot be blank"
validates_presence_of :gender, :message => "Employee gender cannot be blank"

validates_uniqueness_of :emp_id, :message => "Employee id has to be unique, this emp id already exists!"
validates_uniqueness_of :mob_no, :message => "Employee mobile no has to be unique"
validates_uniqueness_of :pan_no, :message => "Employee PAN NO has to be unique"
validates_uniqueness_of :off_email_id, :message => "Employee's RapidThink email id should be unique"
validates_uniqueness_of :pers_email_id, :message => "Employee's personal email id should be unique"

validates_date :dob, :invalid_date_message => "Please enter a valid date for employee's date of birth"
validates_date :doj, :invalid_date_message => "Please enter a valid date for employee's date of joining RapidThink"


validates_length_of :mob_no, :is => 10, :message => "Mobile number entry should contain 10 digits"

validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 18, :message => "Employee should be greater than 18 years of age"
validates_numericality_of :emp_id, :only_integer => true,:greater_than_or_equal_to => 0, :message => "Please enter a positive integer for emp id"
validates_numericality_of :manager_emp_id, :only_integer => true,:greater_than_or_equal_to => 0, :message => "Please enter a positive integer for manager emp id"
validates_numericality_of :mob_no, :only_integer => true, :greater_than_or_equal_to => 0, :message => "Please enter a valid numerical value for employee's mobile no"
validates_numericality_of :phone_no, :only_integer => true, :greater_than_or_equal_to => 0, :message => " Please enter a valid numerical value for employee's phone no"


validates_format_of :off_email_id,
                      :with => /^([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-zA-Z]{2,})$/,
                      :message => 'Employee\'s official email id must have a valid format, e.g. a@b.com'

validates_format_of :pers_email_id,
                      :with => /^([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-zA-Z]{2,})$/,
                      :message => 'Employee\' personal email id must have a valid format, e.g. a@b.com'


has_many :leaves, :class_name => 'Leave', :foreign_key => 'employee_id'
has_one :user, :dependent => :destroy
has_many :subordinates, :class_name => "Employee", :foreign_key => "manager_emp_id"
belongs_to :manager, :class_name => "Employee"

accepts_nested_attributes_for :leaves

def self.search(search)
   if search
    if search.is_i?
      where('emp_id = ?', "#{search.to_i}")
    elsif search.is_a?(String)
       where('last_name LIKE ? or first_name LIKE ? or designation LIKE ?', "%#{search}%" , "%#{search}%", "%#{search}%")
    end
   else
       scoped
   end
end


def dates_cannot_be_in_the_future
       errors.add(:doj,"Joining date cannot be in the future") if 
       (!doj.blank? and doj > Date.today) 
       errors.add(:dob,"Date of birth cannot be in the future") if
       (!dob.blank? and dob > Date.today)
end

def find_leave_approver
emp=self
    while (1) do
          if emp.manager.is_leave_approver?
              manager=emp.manager
              #ActiveRecord::Base.logger.info("The manager now is: #{manager.last_name}, #{manager.emp_id}")
              return manager
           else
              emp=emp.manager
          end
    end
end

def manager
    Employee.find_by_emp_id(self.manager_emp_id)
end


end
