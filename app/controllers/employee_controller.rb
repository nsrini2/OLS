class EmployeeController < ApplicationController
layout 'employee'

  def new
    @employee=Employee.new
  end

  def create
     @employee=Employee.new
     @employee.designation=params[:employee][:designation]
     @employee.emp_id=params[:employee][:emp_id]
     @employee.doj=params[:employee][:doj]
     @employee.manager_name=params[:employee][:manager_name]
     @employee.manager_emp_id=params[:employee][:manager_emp_id]
     @employee.roles=params[:employee][:roles]
     @employee.last_name=params[:employee][:last_name]
     @employee.first_name=params[:employee][:first_name]
     @employee.mob_no=params[:employee][:mob_no]
     @employee.phone_no=params[:employee][:phone_no]
     @employee.dob=params[:employee][:dob]
     @employee.age=params[:employee][:age]
     @employee.address=params[:employee][:address]
     @employee.pan_no=params[:employee][:pan_no]
     @employee.off_email_id=params[:employee][:off_email_id]
     @employee.pers_email_id=params[:employee][:pers_email_id]
     if @employee.save
          flash[:notice] = "New employee #{@employee.emp_id} was created!"
          redirect_to employee_path(@employee)
     else
          flash[:errors]=@employee.errors
          render :action => "new"
     end
  end
 

  def hub
  end

  def leave_balances
  end

  def show
  end

end
