# frozen_string_literal: true

json.array! @orders, partial: 'order', as: :order
