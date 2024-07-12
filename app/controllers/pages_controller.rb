# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def contact
    @contact = StaticPage.find_by(title: 'Contact Us')
  end

  def about
    @about = StaticPage.find_by(title: 'About Us')
  end
end
