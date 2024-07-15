# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController do
  let(:sku) { create(:sku) }

  describe 'GET #index' do
    let(:product) { create(:product) }

    context 'with list of all orders' do
      before do
        product
        get :index, format: 'application/json'
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        json_response = response.parsed_body
        expect(json_response.count).to eq(Product.count)
      end
    end
  end

  describe 'GET #show' do
    let(:product) { create(:product) }

    context 'when showing an existing order' do
      let(:expected_response) do
        {
          'id' => product.id,
          'name' => product.name,
          'price_in_cents' => product.price_in_cents,
          'product_code' => product.sku.product_code
        }
      end

      before do
        get :show, params: { id: product.id }, format: 'application/json'
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        json_response = response.parsed_body
        expect(json_response).to eq(expected_response)
      end
    end
  end

  describe 'POST #create' do
    context 'when creating new product' do
      let(:initial_product_count) { Product.count }

      before do
        initial_product_count
        post :create, params: { sku_id: sku.id, name: 'Product x', price_in_cents: 100 }
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"message":"Product Created Successfully"}')
      end

      it 'Order count change by 1' do
        expect(Product.count).to eq(initial_product_count + 1)
      end
    end

    context "when sku doesn't exist" do
      before do
        post :create, params: { sku_id: 'blah', name: 'Product x', price_in_cents: 100 }
      end

      it_behaves_like 'unsuccessful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"errors":["Sku must exist"]}')
      end
    end
  end

  describe 'PUT #update' do
    let(:product) { create(:product) }

    context 'when updating an existing product' do
      before do
        put :update, params: { id: product.id, price_in_cents: 10 }
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"message":"Price Updated Successfully"}')
      end
    end

    context 'when updating price_in_cents to zero for an existing product to zero' do
      before do
        put :update, params: { id: product.id, price_in_cents: 0 }
      end

      it_behaves_like 'unsuccessful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"errors":["Price in cents must be greater than 0"]}')
      end
    end
  end
end
