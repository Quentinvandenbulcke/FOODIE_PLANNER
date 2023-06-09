class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_time_zone, if: :user_signed_in?

  include Pundit::Authorization
  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo, :username])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo, :username])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  End

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # def set_time_zone
  #   Time.zone = current_user.time_zone
  # end

  # a activer à la fin si on a le temps = reload de l'image à l'inscription
  # before_action :render_photo_registration, only: :create, if: :devise_controller?
  # def render_photo_registration
  #   if resource.save
  #     redirect_to user_path(resource)
  #   else
  #     resource.photo = params[:user][:photo] if params[:user][:photo].present?
  #     render :new, status: :unprocessable_entity
  #   end
  # end
end
