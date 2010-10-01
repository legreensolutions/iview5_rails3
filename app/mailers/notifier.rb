class Notifier < ActionMailer::Base

default_url_options[:host] = "iview5portal.com"    
default :from=>'mail@iview5portal.com'


  def password_reset_instructions(user) 
  		@edit_password_reset_url = edit_password_reset_url(user.perishable_token)  
  		mail(:to=>user.email,:subject=>"Password Reset Instructions") 
 	end 
 
	def activation_instructions(user)
		@account_activation_url = register_url(user.perishable_token)
		mail(:to=>user.email,:subject=>"Activation Instructions")
  end

  def activation_confirmation(user)
  	@root_url = root_url
  	@user = user
  	mail(:to=>user.email,:subject=>"Activation Complete")
  end
end
