class UsersController < ApplicationController
  before_action :set_users, only: [:edit, :update, :show, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
        flash[:success] = "Welcome to the alpha blog #{@user.username}"
        redirect_to articles_path
    else
        render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
        flash[:success] = "The user was successfully updated"
        redirect_to articles_path
    else
        render 'edit'
    end
  end
  
  def index
    @users = User.all
  end
  
  def destroy
    if @user.destroy
      flash[:warning] = "The User was successfully DELETED"
    else
      flash[:danger] = "The User can't be deleted"
    end
    redirect_to articles_path
  end
  
  private
    def set_users
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  
end