# frozen_string_literal: true

#
# Represents a single order
#
class Order < ApplicationRecord
  # has many
  has_many :order_products, dependent: :destroy

  # accepts nested attributes
  accepts_nested_attributes_for :order_products, allow_destroy: true

  # validations
  validates :shipping_date, presence: true

  # methods
  def total
    order_products.sum(&:subtotal)
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value shipping_date updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['order_products']
  end
end
