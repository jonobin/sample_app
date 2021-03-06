class UsersController < ApplicationController
  # current_user is only created here so we need to add :destroy here
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  # TODO: Exercise 10.6.3. Does this solve everything though? And is this the proper solution?
  before_filter :redirect_signed_in_users, :only => [:create, :new]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      # reset password and confirmation
      @user.password.clear
      @user.password_confirmation.clear
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if(@user == current_user)
      flash[:error] = "Cannot destroy own user account"
    else
      @user.destroy
      flash[:success] = "User destroyed."  
    end
    redirect_to users_path
  end
  
  private
  
  def redirect_signed_in_users
    redirect_to(root_path) unless !signed_in?
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
