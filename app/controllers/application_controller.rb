class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  ###protect_from_forgery with: :exception
  protect_from_forgery
  def index
    render  :template=>"pages/home", :layout => "layouts/application"
  end


end
