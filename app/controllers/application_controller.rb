class ApplicationController < ActionController::Base
 
  protect_from_forgery with: :exception

  before_action :configure_devise_params, if: :devise_controller?

  private

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name]
  end  

end
