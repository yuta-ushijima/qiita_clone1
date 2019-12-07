class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #before_action :authenticate_api_v1_user!

  def new
  end

  def create
    current_user = User.find_by(email: session_params[:email], password: session_params[:password])

    if current_user != nil
      render json: current_user

    else
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end