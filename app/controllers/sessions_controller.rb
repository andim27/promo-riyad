class SessionsController < Devise::SessionsController
  respond_to :html, :json
  clear_respond_to
  def create
    #raise "stop"
    self.resource = warden.authenticate!(auth_options)

    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(:user, resource)
    #yield resource if block_given?
    #respond_with resource, location: after_sign_in_path_for(resource)
    redirect_to root_url
  end

  def sign_up_params
    ###devise_parameter_sanitizer.sanitize(:sign_up)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  def after_sign_in_path_for(resource)
    #signed_in_root_path(resource)
    #flash[:notice] = "You are in..!!! Go to edit profile to see the status for the accounts"
    #sign_in_and_redirect(resource)
    redirect_to root_url
  end
end

#
#class SessionsController < Devise::SessionsController
#before_filter :configure_sign_in_params, only: [:create]
#respond_to :html, :json
#  #GET /resource/sign_in
#  def new
#     super
#
#  end
#
#  #POST /resource/sign_in
#  def create
#     # render :json=>params
#     #super
#    resource = warden.authenticate!(:scope => :user, :recall => "#{controller_path}#failure")
#    flash[:notice] = "You are LOG in..!!!"
#    render :status => 200,
#           :json => { :success => true,
#                      :info => "Logged in",
#                      :user => current_user
#           }
#
#  end
#
#  #DELETE /resource/sign_out
#  def destroy
#     super
#    #render :plain=>"sign_out done"
#  end
#
#  def failure
#    render :status => 401,
#           :json => { :success => false,
#                      :info => "Login Credentials Failed"
#           }
#  end
#  protected
#
#  #If you have extra params to permit, append them to the sanitizer.
#  def configure_sign_in_params
#     devise_parameter_sanitizer.for(:sign_in) << :attribute
#  end
#end
