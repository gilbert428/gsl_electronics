#app/controller/products_controller.rb

class ProductsController < ApplicationController
  before_action :set_product_breadcrumbs, only: [:index, :show]

  def index
    @products = filtered_products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    add_breadcrumb @product.category.name, category_path(@product.category)
    add_breadcrumb @product.item_description
  end

  def search
    @products = filtered_products.page(params[:page]).per(10)
    render :index
  end

  private

  def set_product_breadcrumbs
    add_breadcrumb 'Products', products_path
  end

  def filtered_products
    products = Product.includes(:category).all

    if params[:keyword].present?
      products = products.where("item_description LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      products = products.joins(:category).where(categories: { name: params[:category] })
    end

    if params[:category].present?
      products = products.joins(:category).where(categories: { name: params[:category] })
    end

    if params[:on_sale].present?
      products = products.where(sale: true)
    end

    if params[:new].present?
      products = products.where('created_at >= ?', 3.days.ago)
    end

    if params[:recently_updated].present?
      products = products.where('updated_at >= ?', 3.days.ago).where.not(id: Product.where('created_at >= ?', 3.days.ago).pluck(:id))
    end


    products
  end
end
