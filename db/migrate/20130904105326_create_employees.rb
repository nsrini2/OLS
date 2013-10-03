class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :last_name
      t.string :first_name
      t.date :dob
      t.integer :age
      t.string :gender
      t.date :doj
      t.integer :emp_id
      t.string :designation
      t.string :manager_name
      t.integer :manager_emp_id
      t.string :local_addr
      t.string :perm_addr
      t.integer :mob_no
      t.integer :phone_no
      t.string :pan_no
      t.string :off_email_id
      t.string :pers_email_id
      t.string :roles


      t.timestamps
    end
  end
end
