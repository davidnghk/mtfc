class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!
  before_action :set_locale
  before_action :prepare_for_mobile 
  after_action :user_activity

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  protected

  def after_sign_in_path_for(resource_or_scope)
    current_user.today_tasks = Assignment.today.where(worker_user_id: current_user.id).count
    #chatrooms_path #your path
    dashboard_path 
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar, :designation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :designation])
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile/
    end
  end
  
  helper_method :mobile_device?
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
  end

  def user_activity
    current_user.try :touch
  end

end
