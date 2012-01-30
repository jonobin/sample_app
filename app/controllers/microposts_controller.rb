class MicropostsController < ApplicationController

  #removed only clause restricting this to create and destroy
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def index 
    #just redirect to the page for the user, all the microposts for the user will be shown there
    redirect_to user_path(find_user)
  end

  def create
   @micropost = current_user.microposts.build(params[:micropost]) 
   if @micropost.save
     flash[:success] = "Micropost created!"
     redirect_to root_path
   else
     @feed_items = []
     render 'pages/home'
   end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
    def find_user
      @user = User.find(params[:user_id])
    end

    def authorized_user 
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
end