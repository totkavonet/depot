class AddPriceToLineItems < ActiveRecord::Migration[6.1]
  def change
    LineItem.find_each do |li|
      price = li.quantity
      li.update(price: price)
    end
  end

end
