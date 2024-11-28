class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    session[:return_to] || super  # Redirect to the stored URL or default
  end
end
