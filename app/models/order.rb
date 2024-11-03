class Order < ApplicationRecord
  enum pay_type: {
    "Check": 0,
    "Credit Card": 1,
    "Purchase order": 2
  }

  has_many :line_items, dependent: :destroy
  validates :name, :email, :address, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
