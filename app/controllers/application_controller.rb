class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    session.delete(:return_to) || super
  end

  def store_location_for_login
    session[:return_to] = request.fullpath if request.get? && !current_user
  end

  def after_sign_up_path_for(resource)
    if resource.is_admin?
      new_club_path # Redirect admin to club creation
    else
      root_path # Redirect regular users to the homepage
    end
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
