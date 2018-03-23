class CategoriesController < ApplicationController
  before_action :set_categories, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :show, :destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def show
  end
  
  private
    def set_categories
      @user = Category.find(params[:id])
    end
    def category_params
      params.require(:category).permit(:name)
    end
    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admins can perform this action"
        redirect_to categories_path
      end
    end
end