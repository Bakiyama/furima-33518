class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    register_information = [:nickname, :lastname_kanji, :firstname_kanji, :lastname_kana, :firstname_kana, :birthday]
    devise_parameter_sanitizer.permit(:sign_up, keys: register_information)
  end
end
