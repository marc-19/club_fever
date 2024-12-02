class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    session.delete(:return_to) || super
  end

  def store_location_for_login
    session[:return_to] = request.fullpath if request.get? && !current_user
  end
end
