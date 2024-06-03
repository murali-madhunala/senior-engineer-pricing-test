# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    shipping_date { '2024-03-04' }

    trait :with_order_products do
      after(:create) do |order|
        create_list(:order_product, 2, order:)
      end
    end
  end
end
