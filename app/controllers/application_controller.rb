class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  def myprofile
    if user_signed_in?
      @myprofile = current_user.nav || Nav.new
    else
      @myprofile = Nav.new
    end
  end
end
