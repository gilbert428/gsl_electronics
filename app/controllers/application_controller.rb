class ApplicationController < ActionController::Base
  include BreadcrumbsHelper

  before_action :set_categories
  before_action :set_breadcrumbs
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_categories
    @categories = Category.all
  end

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :province, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :province, :address])
  end

  def admin_namespace?
    params[:controller].start_with?('admin/')
  end
end
