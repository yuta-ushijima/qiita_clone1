class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!, only: [:destroy]
  #基本的にメソッドは継承元のものを使えば良いのでここでではパラメータの制限のみを記述している。

  def create
    super
  end

  def destroy
    binding.pry
    #@resource = params
    #current_user = User.find_by(uid: params[:uid])
    super

  end


end