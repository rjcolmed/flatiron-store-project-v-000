class LineItemsController < ApplicationController
  def create
    current_user.current_cart ||= current_user.carts.create

    current_user.current_cart.add_item(params[:item_id])

    if current_user.current_cart.save
      redirect_to cart_path(current_user.current_cart)
    else
      redirect_to store_path
    end
  end
end
