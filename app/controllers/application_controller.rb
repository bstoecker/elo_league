class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :pa

  def pa
    puts "params: #{params}"
  end

  def index
  end

  private

  def set_league
    @league = League.find(params[:league_id])
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) do |u|
  #     u.permit(
  #       :first_name,
  #       :last_name,
  #       :nick_name,
  #       :email,
  #       :password,
  #       :password_confirmation
  #     )
  #   end
  # end
end
