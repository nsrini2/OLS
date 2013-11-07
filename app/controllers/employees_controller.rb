require 'will_paginate/array'
class EmployeesController < ApplicationController
include Utilities
layout 'employee'

before_filter :login_required
before_filter :find_logged_emp

 def new
    @employee=Employee.new
    @user=User.new
    4.times {@employee.leaves.build}
 end

 def index
     #@employees=Employee.all.paginate(:page => params[:page], :per_page => 5)
     @employees=Employee.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
 end

  def create
     @employee=Employee.new
     @user=User.new
     @user.login=params[:employee][:emp_id]
     @user.email=params[:employee][:off_email_id]
     @employee=Employee.new(params[:employee])
     params[:employee][:roles].delete("") 
     if !params[:employee][:roles].empty?
        tmproles=params[:employee][:roles]
     else
        tmproles=[].push(Role::None.id)
     end
     @employee.roles = Role.find_all(*tmproles.map(&:to_i))
     @employee.age=@employee.doj.year-@employee.dob.year
     @user.employee=@employee
     
     if @employee.save && @user.save
         flash[:notice] = "New employee with emp id: #{@employee.emp_id} was successfully created!"
         Notifications.welcome(@user).deliver
         redirect_to employee_path(@employee)
     else
          Rails.logger.info("The errors are: #{@employee.errors.full_messages}")
          flash[:errors]=(@employee.errors)
          #redirect_to new_employee_path
          render :action => "new"
     end
  end
 

 
  def leave_balances
  end


  def show
       @employee=Employee.find(params[:id])
       Rails.logger.info("This employees gender is :#{@employee.gender}")
       render :action => 'show', :layout => '/layouts/employee'
  end


  def edit
      @employee=Employee.find(params[:id])
  end

  def update
     @employee=Employee.find(params[:id])
     
     params[:employee][:roles].delete("") 
     if !params[:employee][:roles].empty?
        tmproles=params[:employee][:roles]
     else
        tmproles=[].push(Role::None.id)
     end
     @employee.update(params[:employee])
     @employee.roles = Role.find_all(*tmproles.map(&:to_i))
     @employee.age=@employee.doj.year-@employee.dob.year

     if @employee.save
         flash[:notice] = "Employee with emp id: #{@employee.emp_id} was successfully updated!"
         redirect_to employee_path(@employee)
     else
         flash[:errors]=@employee.errors
         Rails.logger.info("The errors in update are: #{@employee.errors.each{|i,j| j}}")
          #redirect_to new_employee_path
          render :action => "edit"
     end
 end
   
  def delete
  end

  def destroy
  end


  def find_logged_emp
      @emp=current_emp
  end
end
