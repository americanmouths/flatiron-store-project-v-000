class LineItemsController < ApplicationController
  before_action :authentication_required

  def create
    user = current_user
    if user.current_cart
      user.current_cart.add_item(params[:item_id])
      user.current_cart.save
    else
      user.current_cart = user.carts.create
      user.current_cart.add_item(params[:item_id])
      user.current_cart.save
    end

      user.save
    redirect_to cart_path(user.current_cart)
  end
end
