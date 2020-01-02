module SessionHelpers
  def authenticate_user_headers(user)
    user.create_new_auth_token
  end
end