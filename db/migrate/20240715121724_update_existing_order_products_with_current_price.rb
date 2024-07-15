class UpdateExistingOrderProductsWithCurrentPrice < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        OrderProduct.reset_column_information
        OrderProduct.includes(:product).find_each do |order_product|
          order_product.update(price_in_cents: order_product.product.price_in_cents)
        end
      end

      dir.down { OrderProduct.find_each { |order_product| order_product.update(price_in_cents: 0) } }
    end
  end
end
