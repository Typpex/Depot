class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :order_id, :id, :product, :updated_at, :created_at
  belongs_to :order
  belongs_to :cart
  belongs_to :product

  def total_price
    quantity * price
  end

end
