class CreateSkus < ActiveRecord::Migration[7.1]
  def change
    create_table :skus do |t|
      t.string :product_code, null: false

      t.timestamps
    end
  end
end
