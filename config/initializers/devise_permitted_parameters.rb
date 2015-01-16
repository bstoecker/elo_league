module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    sign_up_handler
    account_update_handler
  end

  private

  def sign_up_handler
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :first_name,
        :last_name,
        :nick_name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end

  def account_update_handler
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :first_name,
        :last_name,
        :nick_name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end
DeviseController.send :include, DevisePermittedParameters
