class Api::V1::BaseApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!
  alias user_signed_in? api_v1_user_signed_in?

  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.first
  end
end
