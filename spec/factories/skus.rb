# frozen_string_literal: true

FactoryBot.define do
  factory :sku do
    sequence(:product_code) { |n| "SKU #{n}" }
  end
end
