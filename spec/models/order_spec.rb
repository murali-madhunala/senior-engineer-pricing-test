# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  it 'has a valid factory' do
    expect(build(:order)).to be_valid
  end

  describe 'associations' do
    it 'has many order_products' do
      expect(described_class.new).to have_many(:order_products)
    end
  end

  describe 'validations' do
    it 'validates presence of shipping_date' do
      expect(described_class.new).to validate_presence_of(:shipping_date)
    end
  end

  describe 'total' do
    let(:order) { build(:order, order_products:) }
    let(:order_products) do
      build_list(:order_product, 2, quantity: 2,
                                    product: build(:product, price_in_cents: 100),
                                    price_in_cents: 100)
    end

    it 'returns the total' do
      expect(order.total).to eq(400)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[created_at id id_value shipping_date updated_at])
    end
  end

  describe 'ransackable_associations' do
    it 'returns an array with order_products' do
      expect(described_class.ransackable_associations).to eq(['order_products'])
    end
  end
end
