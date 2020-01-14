class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    drafts = current_user.articles.draft
    render json: drafts
  end

  def show
    draft = current_user.articles.find(params[:id])
    render json: draft
  end
end
