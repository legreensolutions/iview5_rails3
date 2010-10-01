class User < ActiveRecord::Base

	
	ACTIVE = 1
	
  acts_as_authentic do |c|
	
		c.validates_presence_of :name
		
		c.validates_presence_of :password,:on=>:create,:message=>'cannot be blank'
		
		c.validates_length_of_password_field_options :on=>:create,:within=>8..20,:unless =>Proc.new{|user| user.password.nil?},:message=>'minimum 8 chracters and maximum 20 characters'
	#	c.validates_length_of :password,:on=>:create,:within=>8..20,:unless =>Proc.new{|user| user.password.nil?},:message=>'minimum 8 chracters and maximum 20 characters'
	
		c.validates_length_of_password_field_options :on=>:update,:within => 8..20,:unless =>Proc.new{|user| user.password.nil?},:message=>'minimum 8 chracters and maximum 20 characters'
		
		c.validates_length_of_password_confirmation_field_options   :on=>:update,:within =>8..20 ,:unless =>Proc.new{|user| user.password.nil?},:message=>'minimum 8 chracters and maximum 20 characters'
		
		c.check_passwords_against_database = true
		
  end 
  
 
 
  # Authlogic automatically executes the following methods, if present, upon user action: active?
  def active?
   # active
   if self.active != User::ACTIVE.to_i
   	return false
   else 
     true
   end
  end

	def activate!
    self.active = User::ACTIVE
    save
  end
  
  
 
   # password reset and send mail with a link to reset password
   def deliver_password_reset_instructions!  
 		reset_perishable_token!  
 		Notifier.deliver_password_reset_instructions(self)  
 		end  
 	
 	# Activation email sending
 	def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

	#Confirmation of account activation email
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  
 
 
 
end
