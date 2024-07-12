class ProductsController < ApplicationController
  before_action :set_categories, only: [:index, :show, :search]

  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @products = @products.page(params[:page]).per(10)
    render :index
  end

  private

  def set_categories
    @categories = Product.select(:category).distinct
  end
end
