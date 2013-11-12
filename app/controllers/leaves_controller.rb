class LeavesController < ApplicationController
before_filter :login_required
before_filter :find_user_id
before_filter :find_logged_emp

layout 'leave'

def new
 @leave=Leave.new
end

def create
 @leave=Leave.new(params[:leave])
 @leave.end_date = @leave.end_date.strftime("%d-%b-%Y")
 @leave.start_date = @leave.start_date.strftime("%d-%b-%Y")
 @leave.no_of_days = (@leave.end_date - @leave.start_date).to_i + 1
 @leave.requester_emp_id=@emp.emp_id
 @leave.employee_id=@emp.id
 lt=params[:leave][:leave_type]
 lref_id=@leave.ref_id=("LR" + lt.to_s + rand(10 ** 10).to_s.rjust(10,'0')).to_s
 @leave.approver_emp_id=@emp.find_leave_approver.emp_id
                         
 
 if @leave.save
      flash[:notice]="Leave request #{lref_id} was submitted successfully!"
      redirect_to :action => 'new'
  else
      flash[:errors]="(Error creating new leave request, #{@leave.errors})"
      redirect_to :action => 'new'
 end
end

def my_leave_history

end




def find_user_id
    @uid=current_user_id
end
    
def find_logged_emp
    @emp=current_emp
end

end
