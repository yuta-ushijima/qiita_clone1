class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

    def sign_up_params
      # 新規登録時のパラメータの制限の定義をしている
      params.permit(:name, :email, :password)
    end
end
