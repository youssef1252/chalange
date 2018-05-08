# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  # end

  # POST /resource/sign_in
  def create
    if request.post?
      user = User.find_by(email: params[:user][:email])
      if !user
        begin
          user = User.create!(user_params)
        rescue => e
          flash[:alert] = "Invalid email or password"
          ap "An error occured: #{e}"
          return
        end
      end
      sign_in user
      redirect_url = '/'
      redirect_to redirect_url
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
