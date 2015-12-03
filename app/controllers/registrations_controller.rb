class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  #include DeviseHelper
  #POST /resource
  def create
    #build_resource(sign_up_params)
    ###configure_sign_up_params
    #@resource = warden.authenticate!(:scope => :user, :recall => "#{controller_path}#failure")
    #sign_up(resource_name, resource)
    #render :status => 200, :json => { :success => true, :info => "Logged in", :user => current_user }
    #-------------------------------------------------------------------
    resource=build_resource(sign_up_params)

    resource.save
    #render :status => 200, :json => { :success => true, :info => "Register in", :user => current_user }
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        #set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        render :status => 200, :json => { :success => true, :info => "Registered in", :user => current_user, :url_to=>root_url }
      else
        #set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        render :status => 200, :json => { :success => true, :info => "Not active auth", :user => current_user, :url_to=>root_url }
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      #respond_with resource resource.errors.full_messages.first
      render :status => 401, :json => { :success => false, :info =>resource.errors.full_messages.first}
    end
  end

  def failure
    #render :status => 401, :json => { :success => false, :info =>devise_error_messages!}
    render :status => 401, :json => { :success => false, :info =>@resource.errors.to_s}
    #render :status => 401, :json => { :success => false, :info =>env['warden']}
    #raise "stop"
  end


  #helper_method :resource_name, :resource, :devise_mapping
  #
  #def resource_name
  #  :user
  #end
  #
  #def resource
  #  @resource ||= User.new
  #end
  #
  #def devise_mapping
  #  @devise_mapping ||= Devise.mappings[:user]
  #end


  protected

  def after_sign_up_path_for(resource)

    signed_in_root_path(resource)
  end

  def sign_up_params
    ###devise_parameter_sanitizer.sanitize(:sign_up)
    params.require(:user).permit(:name, :location, :about, :email, :password, :password_confirmation)


  end
  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end


#class RegistrationsController < Devise::RegistrationsController
###before_filter :configure_sign_up_params, only: [:create]
#before_filter :configure_account_update_params, only: [:update]
####clear_respond_to
####respond_to :html, :json
###respond_to :json
#  #GET /resource/sign_up
#  def new
#     super
#  end
#
#  #POST /resource
#  def create
#    ##sign_up(resource_name, resource)
#    ##render :status => 200, :json => { :success => true, :info => "Logged in", :user => current_user }
#super
#    ##build_resource(sign_up_params)
#    ##configure_sign_up_params
#    ##resource = warden.authenticate!(:scope => :user, :recall => "application#index")
#    ##sign_up(resource_name, resource)
#    #logger.info resource.to_s
#    ##render :status => 200, :json => { :success => true, :info => "Logged in", :user => current_user }
#
##console
##    if resource.save
##      respond_to do |format|
##        format.html {
##          yield resource if block_given?
##          if resource.active_for_authentication?
##            set_flash_message :notice, :signed_up if is_flashing_format?
##            sign_up(resource_name, resource)
##            respond_with resource, :location => after_sign_up_path_for(resource)
##          else
##            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
##            expire_data_after_sign_in!
##            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
##          end
##        }
##        format.js {
##          flash[:notice] = "Created account, signed in."
##          #render :template => "remote_content/devise_success_sign_up.js.erb"
##          render :plain => "error"
##          flash.discard
##          sign_up(resource_name, resource)
##        }
##      end
##    else
##      respond_to do |format|
##        format.html {
##          clean_up_passwords resource
##          respond_with resource
##        }
##        format.js {
##          flash[:alert] = @user.errors.full_messages.to_sentence
##          #render :template => "remote_content/devise_errors.js.erb"
##          render :plain => "save error"
##          flash.discard
##        }
##      end
##    end
#
#    #resource = warden.authenticate!(:scope => resource_name, :recall => "application#index")
#          #resource.save!
#          #sign_in_without_redirect(resource_name, resource)
#          #@after_sign_in_path = after_sign_in_path_for(resource)
#    ##super
#    ##build_resource sign_up_params
#    ##super
#    ### raise "STOP reG"
#    #resource.name = params[:user][:name]
#    #resource.email = params[:user][:email]
#    #resource.location = params[:user][:location]
#    #resource.about = params[:user][:about]
#    #resource.save
#    #set_flash_message :notice, :signed_up if is_flashing_format?
#    #sign_up(resource_name, resource)
#
#    #build_resource(sign_up_params)
#    #resource.save
#    #yield resource if block_given?
#    #if resource.persisted?
#    #  if resource.active_for_authentication?
#    #    set_flash_message :notice, :signed_up if is_flashing_format?
#    #    sign_up(resource_name, resource)
#    #    ##respond_with resource, location: after_sign_up_path_for(resource)
#    #  else
#    #    set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
#    #    expire_data_after_sign_in!
#    #    ##respond_with resource, location: after_inactive_sign_up_path_for(resource)
#    #  end
#    #else
#    #  clean_up_passwords resource
#    #  set_minimum_password_length
#    #  #respond_with resource
#    #end
#
#    ##sign_in_and_redirect(resource)
#    #render :json=>params
#    #resource = warden.authenticate!(:scope => :users, :recall => "#{controller_path}#failure")
#    #render :status => 200,
#    #       :json => { :success => true,
#    #                  :info => "Logged in",
#    #                  :user => current_user
#    #       }
#  end
#
#  #GET /resource/edit
#  def edit
#     super
#  end
#
#  #PUT /resource
#  def update
#     super
#  end
#
#  #DELETE /resource
#  def destroy
#     super
#  end
#
#  #GET /resource/cancel
#  # Forces the session data which is usually expired after sign
#  # in to be expired now. This is useful if the user wants to
#  # cancel oauth signing in/up in the middle of the process,
#  # removing all OAuth session data.
#  def cancel
#     super
#  end
#
#  def failure
#    render :status => 401,
#         :json => { :success => false,
#                    :info => "Register Credentials Failed"
#         }
#  end
#
#  def sign_in_without_redirect(resource_or_scope, resource=nil)
#    scope = Devise::Mapping.find_scope!(resource_or_scope)
#    resource ||= resource_or_scope
#    sign_in(scope, resource) unless warden.user(scope) == resource
#  end
#
#helper_method :resource_name, :resource, :devise_mapping
#
#    def resource_name
#      :user
#    end
#
#    def resource
#      @resource ||= User.new
#    end
#
#    def devise_mapping
#      @devise_mapping ||= Devise.mappings[:user]
#    end
#  protected
#
#  # If you have extra params to permit, append them to the sanitizer.
#  def configure_sign_up_params
#     devise_parameter_sanitizer.for(:sign_up) << :attribute
#  end
#
#  # If you have extra params to permit, append them to the sanitizer.
#  def configure_account_update_params
#     devise_parameter_sanitizer.for(:account_update) << :attribute
#  end
#
#  # The path used after sign up.
#  def after_sign_up_path_for(resource)
#     super(resource)
#  end
#
#  # The path used after sign up for inactive accounts.
#  def after_inactive_sign_up_path_for(resource)
#     super(resource)
#  end
#
#
#  private
#  def sign_up_params
#    allow = [:name,:email, :password, :location,:about]
#    params.require(resource_name).permit(allow)
#  end
#end
