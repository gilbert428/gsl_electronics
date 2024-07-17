# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include BreadcrumbsHelper

  before_action :set_categories
  before_action :set_breadcrumbs

  helper_method :current_customer

  private

  def set_categories
    @categories = Category.all
  end

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
  end

  def current_customer
    # Assuming you store the customer ID in the session upon login
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

end
