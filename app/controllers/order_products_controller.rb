# frozen_string_literal: true

#
# Defines the create, update and destroy actions for the Order Products
#
class OrderProductsController < ApplicationController
  #
  # ######### @input params #########
  # product_id {integer}
  # quantity {integer}
  # #################################
  #
  def create
    # Assumption: Shipping order date would be 5 days after the order is created
    @order = Order.new(shipping_date: Time.zone.today + 5)
    @order.order_products.new(product_id: params[:product_id], quantity: params[:quantity].to_i)

    if @order.save
      render json: { message: 'Order Created Successfully' }
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #
  # ######### @input params #########
  # id {integer} -- OrderProduct ID
  # #################################
  #
  def update
    @order_product = OrderProduct.find(params[:id])
    @order_product.quantity = @order_product.quantity + params[:quantity].to_i

    if @order_product.save
      render json: { message: 'Order Updated Successfully' }, status: :ok
    else
      render json: { errors: @order_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #
  # ######### @input params #########
  # id {integer} -- OrderProduct ID
  # #################################
  #
  def destroy
    @order_item = OrderProduct.find(params[:id])
    @order_item.destroy
    
    render json: { message: 'Successfully removed Product from Order' }, status: :ok
  end
end
