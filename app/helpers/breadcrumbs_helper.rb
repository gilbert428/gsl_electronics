# app/helpers/breadcrumbs_helper.rb
module BreadcrumbsHelper
  def render_breadcrumbs
    content_tag :nav, class: 'breadcrumbs' do
      content_tag :ul do
        breadcrumbs.map do |crumb|
          content_tag :li do
            if crumb[:path].present?
              link_to crumb[:name], crumb[:path]
            else
              crumb[:name]
            end
          end
        end.join.html_safe
      end
    end
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << { name: name, path: path }
  end
end
