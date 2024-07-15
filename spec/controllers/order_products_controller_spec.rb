# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProductsController do
  let(:product) { create(:product) }

  describe 'POST #create' do
    context 'when creating new order' do
      let(:initial_order_count) { Order.count }

      before do
        initial_order_count
        get :create, params: { product_id: product.id, quantity: 10 }
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"message":"Order Created Successfully"}')
      end

      it 'Order count change by 1' do
        expect(Order.count).to eq(initial_order_count + 1)
      end
    end

    context 'when quantity is zero' do
      before do
        post :create, params: { product_id: product.id, quantity: 0 }
      end

      it_behaves_like 'unsuccessful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"errors":["Order products quantity must be greater than 0"]}')
      end
    end
  end

  describe 'PUT #update' do
    let(:order) { create(:order, :with_order_products) }

    context 'when updating an existing order' do
      before do
        put :update, params: { id: order.order_products.first.id, quantity: 10 }
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"message":"Order Updated Successfully"}')
      end
    end

    context 'when updating existing order to make the quantity zero' do
      before do
        order_product = order.order_products.first
        put :update, params: { id: order_product.id, quantity: -order_product.quantity }
      end

      it_behaves_like 'unsuccessful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"errors":["Quantity must be greater than 0"]}')
      end
    end
  end

  describe 'PUT #destroy' do
    let!(:order) { create(:order, :with_order_products) }

    context 'when deleting an existing order' do
      before do
        delete :destroy, params: { id: order.order_products.first.id, quantity: 10 }
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.body).to eq('{"message":"Successfully removed Product from Order"}')
      end
    end
  end
end
