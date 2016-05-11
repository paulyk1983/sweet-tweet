class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # protect_from_forgery with: :null_session
  helper_method :current_user
 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
