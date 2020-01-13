class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  before_action :authenticate_user!

  def index
    drafts = current_user.Article.drafts
    render json: drafts
  end

  def show
    draft = current_user.Article.draft.find(params[:id])
    render json: draft
  end
end
