# frozen_string_literal: true

#
# Represents a stock unit
#
class Sku < ApplicationRecord
  # has many
  has_many :products, dependent: :destroy

  # validations
  validates :product_code, presence: true

  # methods
  def display_name
    product_code
  end

  # class methods
  def self.ransackable_associations(_auth_object = nil)
    ['products']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value product_code updated_at]
  end
end
