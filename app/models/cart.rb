class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, :through => :line_items
  belongs_to :user


  def total
    @summ = 0
    @summ = self.items.inject(0) {|sum, item| sum + item.price}
  end

  def add_item(item)
    line_item = LineItem.find_by(item_id: item)
    if line_item
      line_item.quantity += 1
    else
      line_item = LineItem.new(item_id: item, cart_id: self.id)
    end
      line_item
  end

  def checkout
    self.update(status: "submitted")
    self.inventory_update
    self.user.current_cart_id = nil
    self.user.save
    self.save
  end

  def inventory_update
    self.line_items.each do |line_item|
      item = Item.find_by(id: line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
  end

end
