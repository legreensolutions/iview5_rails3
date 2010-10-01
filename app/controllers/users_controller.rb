class UsersController < ApplicationController
 before_filter :require_user, :only => [:edit, :update]
# before_filter :admin_required, :only => [:index]
#  helper_method :sort_column, :sort_direction 
#respond_to :html, :xml, :json
  def new
    @user = User.new
  end
  
  def index 
 		
 		 	 users = User.all.paginate(:page => params[:page], :per_page => params[:rows])
 		 	 #.order("#{params[:sidx]} #{params[:sord]}")
 		 	 
 		 #	 respond_with(users.to_jqgrid_json([:id,:name,:email],                                #params[:page], params[:rows], users.total_entries) )
 		 
 		 respond_to do |format|
    format.html
    format.json { render :json => users.to_jqgrid_json([:id,:name,:email], 
                                                       params[:page], params[:rows], users.total_entries) }
   
  end
  
 		#	@users_grid = initialize_grid(User,:per_page => 25)

   def create

    @user = User.new(params[:user])
   
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      Notifier.activation_instructions(@user).deliver
      flash[:notice] = "Your account has been created. Please check your e-mail for your 					account activation instructions!"
    
      redirect_to login_path
    else
      render :action => :new
    end
  end

  
  def show
  	@user = User.find(params[:id])
  
  end
  
  def edit
  	@user = User.find(params[:id])
  end
  
  def update 
  	 @user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(@user.id)
    else
      render :action => :edit
    end
  end
  
  # DELETE /books/1
	# DELETE /books/1.xml
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to(users_path) }
			format.xml  { head :ok }
		end
	end

end


