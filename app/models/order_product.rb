# frozen_string_literal: true

#
# Represents a line item on the order
# Contains the quantity of the given product added to the order
#
class OrderProduct < ApplicationRecord
  # belongs to
  belongs_to :order
  belongs_to :product

  # validations
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, presence: true

  before_create :set_price_in_cents

  #
  # Calculates the subtotal for the given order product
  #
  # @return [Integer] the subtotal
  #
  def subtotal
    quantity * price_in_cents
  end

  #
  # Setting price_in_cents before creating the record by taking current Product price.
  # This cannot be changed once the record is created
  #
  def set_price_in_cents
    self.price_in_cents = product.price_in_cents
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value order_id product_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
