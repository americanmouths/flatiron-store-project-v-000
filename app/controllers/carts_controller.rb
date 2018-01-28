class CartsController < ApplicationController
  before_filter :user_signed_in?, only: [:show, :checkout]

  def show
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    @cart.checkout
    redirect_to cart_path(@cart)
  end

end
