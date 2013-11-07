require 'digest/sha1'
class User < ActiveRecord::Base

  attr_accessible :email, :hashed_password, :login
  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation

  validates_presence_of :login, :message => "Login id cannot be blank"
  validates_uniqueness_of :login, :message => "Login id has to be unique, this login id already exists!"
  
  
  validates_presence_of :email, :message => "Employee's RapidThink email id cannot be blank"
  validates_uniqueness_of :email, :message => "Employee's RapidThink email should be unique"
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-zA-Z]{2,})$/,
                      :message => 'Employee\' email id must have a valid format, e.g. a@b.com'

  
  #validates_length_of :password, :within => 5..20
  validates_confirmation_of :password

  belongs_to :employee, :dependent => :destroy


  def self.authenticate(login,pass)
     u=find_by_login(login)
      return nil if u.nil?
     return u if User.encrypt(pass,u.salt)==u.hashed_password
     nil
  end

  def password=(pass)
     @password=pass
     self.salt=User.random_string(10) if !self.salt
     self.hashed_password=User.encrypt(@password,self.salt)
  end

  def send_new_password
      new_pass=User.random_string(10)
      self.password=self.password_confirmation=new_pass
      self.save
      Notifications.forgot_password(self.email,self.login,new_pass, self.employee).deliver
  end

  protected

  def self.encrypt(pass,salt)
      Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
      chars=("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass=""
      1.upto(len){ |i| newpass << chars[rand(chars.size-1)] }
      return newpass
  end

 end
