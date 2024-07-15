# frozen_string_literal: true

#
# Defines the index and show actions for the Orders
#
class OrdersController < ApplicationController
  #
  # ######### @input params #########
  # #################################
  #
  def index
    @orders = Order.includes(order_products: { product: :sku }).all
  end

  #
  # ######### @input params #########
  # id {integer} -- Order ID
  # #################################
  #
  def show
    @order = Order.includes(order_products: { product: :sku }).find(params[:id])
  end
end
