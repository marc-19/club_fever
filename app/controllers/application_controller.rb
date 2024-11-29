class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    session.delete(:return_to) || root_path # Redirect to the stored path or default to root_path
  end
end
