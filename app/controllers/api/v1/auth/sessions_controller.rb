class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!, only: [:destroy]
  #基本的にメソッドは継承元のものを使えば良いのでここでではパラメータの制限のみを記述している。
  skip_before_action :verify_authenticity_token
  def create

    super
    binding.pry
  end

  def destroy

    #@resource = params
    #current_user = User.find_by(uid: params[:uid])
    binding.pry
    super
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end