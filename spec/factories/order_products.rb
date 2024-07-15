# frozen_string_literal: true

FactoryBot.define do
  factory :order_product do
    order
    product
    quantity { 1 }
    price_in_cents { 1000 }
  end
end
