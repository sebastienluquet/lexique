class ApplicationController < ActionController::Base
  protect_from_forgery
  # gestion de variable de session pour savoir si l'utilisateur est anonyme/admin
  helper_method :current_user
  protected
    def current_user=(new_user)
      session[:user_id] = new_user ? 1 : nil
    end
    def current_user
      @current_user ||= login_from_session
    end
    def login_from_session
      user = Object.new
      def user.is_admin?
        true
      end
      self.current_user = user if session[:user_id]
    end
end
