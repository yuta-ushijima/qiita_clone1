class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!

  def new
  end

  def create
    #継承についてDeviseTokenAuth::SessionsControllerは公式ドキュメントを確認する
    super
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end