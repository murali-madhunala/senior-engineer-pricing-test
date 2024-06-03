class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price_in_cents, null: false
      t.references :sku, null: false, foreign_key: true

      t.timestamps
    end
  end
end
