# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController do
  let(:order) { create(:order, :with_order_products) }

  describe 'GET #index' do
    context 'when lists all orders' do
      before do
        order
        get :index, format: 'application/json'
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected success response' do
        expect(response.parsed_body.count).to eq(Order.count)
      end
    end
  end

  describe 'GET #show' do
    context 'when showing an existing order' do
      before do
        get :show, params: { id: order.id }, format: 'application/json'
      end

      it_behaves_like 'successful request'

      it 'returns response in JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'has the exact keys' do
        expect(response.parsed_body.keys).to contain_exactly('id', 'shipping_date', 'order_products', 'order_total')
      end

      it 'has exact keys in order_products attribute' do
        expect(response.parsed_body['order_products']).to be_an_instance_of(Array)
      end
    end
  end
end
