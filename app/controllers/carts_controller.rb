class CartsController < ApplicationController
  before_filter :authenticate_user!

  def show
    (redirect_to new_user_session_path) unless user_signed_in?
  end

  def checkout
    current_user.current_cart.line_items.each do |line_item|
      item = Item.find_by(id: line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
    cart = current_user.current_cart 
    cart.user_id = nil
    cart.save
    redirect_to cart_path(cart)
  end
end
