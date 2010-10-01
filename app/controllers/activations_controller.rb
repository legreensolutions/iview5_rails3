class ActivationsController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
  def new
      @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
       if @user.active?
       	flash[:notice] = 'Your account is already active'
       	redirect_to login_path
       end
    end

    def create
      @user = User.find(params[:id])
      raise Exception if @user.active?
      if @user.activate!
        @user.deliver_activation_confirmation!
        redirect_to user_url(@user.id)
      else
        render :action => :new
      end
    end
    
	def activate_account
		@user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
		if @user
		if @user.activate!
		flash[:notice] = "Your account activated and you can login now"
			Notifier.activation_confirmation(@user).deliver
			redirect_to login_path
		end
		else
			flash[:notice] = 'User not found'
			redirect_to root_url
		end
	end

end
