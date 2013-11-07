# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131101080907) do

  create_table "employees", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.date     "dob"
    t.integer  "age"
    t.string   "gender"
    t.date     "doj"
    t.integer  "emp_id"
    t.string   "designation"
    t.string   "manager_name"
    t.integer  "manager_emp_id"
    t.string   "local_addr"
    t.string   "perm_addr"
    t.integer  "mob_no"
    t.integer  "phone_no"
    t.string   "pan_no"
    t.string   "off_email_id"
    t.string   "pers_email_id"
    t.string   "roles"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "leaves", :force => true do |t|
    t.integer  "employee_id"
    t.string   "ref_id"
    t.integer  "requester_emp_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "no_of_days"
    t.text     "request_remarks"
    t.date     "request_date"
    t.integer  "approver_emp_id"
    t.string   "action"
    t.text     "action_remarks"
    t.text     "admin_comments"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "leave_type"
  end

  create_table "users", :force => true do |t|
    t.integer  "login"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "salt"
    t.integer  "employee_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
