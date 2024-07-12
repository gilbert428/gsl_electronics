# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all

    if params[:keyword].present?
      @products = @products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where(categories: { name: params[:category] })
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.includes(:category).all

    if params[:keyword].present?
      @products = @products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where(categories: { name: params[:category] })
    end

    @products = @products.page(params[:page]).per(10)
    render :index
  end
end
