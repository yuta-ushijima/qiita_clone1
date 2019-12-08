class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!
  #基本的にメソッドは継承元のものを使えば良いのでここでではパラメータの制限のみを記述している。
  skip_before_action :verify_authenticity_token
  def create
    super
  end

  def destroy
    #@resource = params
    binding.pry
    super
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end