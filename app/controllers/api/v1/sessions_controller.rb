class Api::V1::SessionsController < Api::BaseController

  skip_before_action :verify_access?, only: [:create]

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.send :generate_authentication_token
      user.update
      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token
    user.save
    head 204
  end
end
