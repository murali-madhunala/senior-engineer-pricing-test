# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sku do
  it 'has a valid factory' do
    expect(build(:sku)).to be_valid
  end

  describe 'associations' do
    it 'has many products' do
      expect(described_class.new).to have_many(:products)
    end
  end

  describe 'validations' do
    it 'validates presence of product_code' do
      expect(described_class.new).to validate_presence_of(:product_code)
    end
  end

  describe 'display_name' do
    let(:sku) { build(:sku) }

    it 'returns the product_code' do
      expect(sku.display_name).to eq(sku.product_code)
    end
  end

  describe 'ransackable_associations' do
    it 'returns an array with products' do
      expect(described_class.ransackable_associations).to eq(['products'])
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[created_at id id_value product_code updated_at])
    end
  end
end
