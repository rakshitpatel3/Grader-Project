class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :log_user_sign_in_attempt
  include Pagy::Backend
  
  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  private

  def log_user_sign_in_attempt
    if params[:controller] == 'devise/sessions' && params[:action] == 'create'
      Rails.logger.debug "Login attempt for email: #{params[:user][:email]}"
    end
  end
end