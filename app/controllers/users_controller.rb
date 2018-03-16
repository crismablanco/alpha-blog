class UsersController < ApplicationController
  before_action :set_users, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  
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
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
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
    @users = User.paginate(page: params[:page], per_page: 5)
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
    def require_same_user
      if current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
end