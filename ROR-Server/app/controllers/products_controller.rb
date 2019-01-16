class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  #GET/products/1/show_products
  def show_products
    @req_category_products=Product.where('quantity!=0').where(:product_category_id=>params[:id])
    render json: @req_category_products
  end
  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update_quantity
    product=Product.where(:id=>params[:id]).first
    @updated=Product.update(params[:id],:quantity=>product.quantity+1)
    render json: @updated
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.fetch(:product, {})
      params.require(:product).permit(:name, :product_category_id,:quantity)
    end
end
