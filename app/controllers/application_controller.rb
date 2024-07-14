# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include BreadcrumbsHelper

  before_action :set_categories
  before_action :set_breadcrumbs

  private

  def set_categories
    @categories = Category.all
  end

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
  end
end
