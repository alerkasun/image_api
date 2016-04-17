class Api::V1::UsersController < Api::BaseController
  skip_before_action :verify_access?, only: [:create]

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def delete
    if user_params[:email].present?
      user = User.find_by(email: user_params[:email])
    else
      render :status => 200,  :json => {:status=>"Errors",:message=>"We didn't recognize the user email or api token you entered. Please try again."}
    end
    user.destroy!
    render :status => 204,  :json => {:status=>"Success",:message=>"User was successfully deleted"}
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end




  
