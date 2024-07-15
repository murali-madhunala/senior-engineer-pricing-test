class AddPriceInCentsToOrderProducts < ActiveRecord::Migration[7.1]
  def up
    add_column :order_products, :price_in_cents, :integer, null: false
  end

  def down
    remove_column :order_products, :price_in_cents
  end
end
