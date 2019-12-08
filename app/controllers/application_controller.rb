# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller? # APIではCSRFチェックをしない
  protect_from_forgery with: :null_session

  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!
  alias user_signed_in? api_v1_user_signed_in?
end
