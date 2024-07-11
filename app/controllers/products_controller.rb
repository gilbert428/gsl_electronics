class ProductsController < ApplicationController
  def index
    @products = Product.all
    puts "Products loaded: #{@products.inspect}" # Debugging line
  end

  def show
    @product = Product.find(params[:id])
    puts "Product loaded: #{@product.inspect}" # Debugging line
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
end
