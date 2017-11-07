class CartsController < ApplicationController
  before_filter :authenticate_user!

  def show
    (redirect_to new_user_session_path) unless user_signed_in?
  end

  def checkout
    this_cart.line_items.each do |line_item|
      item = Item.find_by(id: line_item.item_id)
      item.tap { |i| i.inventory -= line_item.quantity }.save
    end

    this_cart.tap { |cart| cart.user_id = nil }.save
    redirect_to cart_path(this_cart)
  end
end
