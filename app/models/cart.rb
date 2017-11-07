class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items

  def add_item(item_id)
    line_item = line_items.find_by(item_id: item_id)
    
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = line_items.build(item_id: item_id)
      line_item.quantity = 1
    end
    line_item
  end

  def total
    line_items.each.sum do |line_item|
      line_item.item.price * line_item.quantity
    end
  end

end
