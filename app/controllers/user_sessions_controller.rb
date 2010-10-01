class UserSessionsController < ApplicationController
   def new
    @user_session = UserSession.new
    
  end
  
  def create
  	@user_session = UserSession.new(params[:user_session])

   	if @user_session.save

		  flash[:notice] = "Logged in successfully."
		  unless session[:saved_location].blank?
		  	redirect_to session[:saved_location]
		  	session[:saved_location] = ""
		  else
			  redirect_to :action=>'welcome'
		 end
		else
	    render :action => 'new'
    end
  end
  
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
 
 
 def welcome
  @result = `perl #{Rails.root.to_s}/perl/one.pl`
 	render :layout=>'welcome' 
 end
 
end
