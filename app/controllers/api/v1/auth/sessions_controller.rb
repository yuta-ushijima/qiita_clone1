class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!
  #基本的にメソッドは継承元のものを使えば良いのでここでではパラメータの制限のみを記述している。
  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end