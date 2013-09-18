class EmployeeController < ApplicationController
layout 'employee'

  def new
    @employee=Employee.new
  end

  def hub
  end

  def create
  end

  def leave_balances
  end
end
