class SavePriceIntoLineItems < ActiveRecord::Migration  
  def up
    add_column :line_items, :price, :float
    LineItem.all.each do |li|
      p = Product.find li.product_id
      li.update_column :price, p.price
    end
  end

  def down
    remove_column :line_items, :price
  end
end
