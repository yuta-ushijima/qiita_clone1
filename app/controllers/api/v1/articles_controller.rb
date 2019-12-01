class Api::V1::ArticlesController < Api::V1::BaseApiController
  #before_action :find_article, only[:update, :destroy]

  def index
    articles = Article.all
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
    article = current_user.articles.create!(article_params)
    render json: article
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
  end

  private

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def find_article
      article = current_user.articles.find(params[:id])
    end
 end
