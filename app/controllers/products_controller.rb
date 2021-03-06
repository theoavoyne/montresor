class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_product, only: [ :edit, :update, :destroy, :show ]

  def show
    authorize @product
    @product_owner = @product.user == current_user
    @offer_accepted = Offer.where(user: current_user, product: @product, state: "accepted").take
    @product_sold = Offer.where(product: @product, state: "accepted").take
    @offer_sent = Offer.where(user: current_user, product: @product).take
  end

  def new
    @product = current_user.products.build
    authorize @product
  end

  def create
    @product = current_user.products.build(product_params)
    authorize @product

    if @product.save
        redirect_to root_path
    else
       render new_product_path
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    @product.update(product_params)

    redirect_to root_path
  end

  def destroy
    authorize @product
    @product.destroy

    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:description, :name, :price, :category, :photo, :photo_cache)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
