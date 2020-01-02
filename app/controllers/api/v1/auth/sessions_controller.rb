class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  before_action :authenticate_user!, only: [:destroy]

  def create
    super
  end

  def destroy
    super
  end
end
