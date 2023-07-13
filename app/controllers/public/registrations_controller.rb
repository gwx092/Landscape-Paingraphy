class Public::RegistrationsController < ApplicationController
  #許可したパラメータを使用
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def new
  end
  
  def after_sign_in_path_for(resource)
    flash[:notice] = "新規登録しました"
    user_path
  end
  
  protected
  #許可するパラメータの指定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :nickname, :email, :encrypted_password, :password_confirmation])
  end
end
