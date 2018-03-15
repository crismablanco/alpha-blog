class ArticlesController < ApplicationController
  before_action :set_articles, only: [:edit, :update, :show, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
        flash[:success] = "Article was successfully created"
        redirect_to articles_path(@article)
    else
        render 'new'
    end
  end

  def show
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
        flash[:success] = "Article was successfully updated"
        redirect_to articles_path
    else
        render 'edit'
    end
  end
  
  def index
    @articles = Article.all
  end
  
  def destroy
    if @article.destroy
      flash[:warning] = "Article was successfully DELETED"
    else
      flash[:danger] = "Article can't be deleted"
    end
    redirect_to articles_path
  end
  
  private
    def set_articles
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end