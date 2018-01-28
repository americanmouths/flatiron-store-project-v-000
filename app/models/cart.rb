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

end
