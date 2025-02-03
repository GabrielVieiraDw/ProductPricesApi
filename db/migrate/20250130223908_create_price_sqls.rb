class CreatePriceSqls < ActiveRecord::Migration[6.1]
  def change
    create_table :price_sqls do |t|
      t.string  :country, null: false
      t.string  :brand
      t.string  :product_id, null: false
      t.string  :product_name, null: false
      t.string  :shop_name, null: false
      t.string  :product_category_id
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string  :url
      t.timestamps
    end

    add_index :price_sqls, [:country, :product_id, :shop_name], unique: true
  end
end