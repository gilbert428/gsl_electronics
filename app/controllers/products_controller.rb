class ProductsController < ApplicationController
  def index
    @categories = Product.select(:category).distinct
    @products = Product.all

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    if params[:filter] == "on_sale"
      @products = @products.where(on_sale: true)
    elsif params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ?", 3.days.ago)
    end

    @filtered_products = @products.page(params[:page]).per(10)
    @all_products = Product.all.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
    @categories = Product.select(:category).distinct
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @filtered_products = @products.page(params[:page]).per(10)
    @all_products = Product.all.page(params[:page]).per(10)
    render :index
  end
end
