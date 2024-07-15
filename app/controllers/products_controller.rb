# frozen_string_literal: true

#
# Defines the index, show, create and update actions for the Products
#
class ProductsController < ApplicationController
  #
  # ######### @input params #########
  # #################################
  #
  def index
    @products = Product.includes(:sku).all
  end

  #
  # ######### @input params #########
  # id {integer} -- Product ID
  # #################################
  #
  def show
    @product = Product.includes(:sku).find(params[:id])
  end

  #
  # ######### @input params #########
  # sku_id {integer}
  # name {String}
  # price_in_cents {integer} - should greater than zero
  # #################################
  #
  def create
    @product = Product.new(sku_id: params[:sku_id], name: params[:name], price_in_cents: params[:price_in_cents])

    if @product.save
      render json: { message: 'Product Created Successfully' }, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #
  # ######### @input params #########
  # id {integer} -- Product ID
  # price_in_cents {integer} - should greater than zero
  # #################################
  #
  def update
    @product = Product.find(params[:id])
    @product.price_in_cents = params[:price_in_cents]

    if @product.save
      render json: { message: 'Price Updated Successfully' }, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
