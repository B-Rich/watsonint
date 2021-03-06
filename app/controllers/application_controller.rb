class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private
  
    def current_user
      # return @current_user if defined?(@current_user)
      # @current_user = current_user_session && current_user_session.user
      @current_user = current_user_session && current_user_session.record
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def require_user
      unless signed_in?
        redirect_to (session[:return_to] || login_path) and return
      end
    end

    def signed_in?
      return @signed_in if defined?(@signed_in)
      @signed_in = !current_user.nil?
    end
end
