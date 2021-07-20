class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller? 
   
   include SessionsHelper
   include Pagy::Backend
    
   private

   def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
   end
   
   def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
end
