# frozen_string_literal: true

json.id order.id
json.shipping_date order.shipping_date
order_total = 0
json.order_products do
  json.array! order.order_products do |order_product|
    json.product order_product.product, partial: 'products/product', as: :product
    json.quantity order_product.quantity
    json.price_in_cents order_product.price_in_cents
    json.subtotal order_product.subtotal
    order_total += order_product.subtotal
  end
end
json.order_total order_total
