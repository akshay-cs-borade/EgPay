class CreateProductVariants < ActiveRecord::Migration[7.1]
  def change
    create_table "product_variants", force: :cascade do |t|
      t.integer "product_id", null: false
      t.integer "color_id", null: false
      t.integer "size_id", null: false
      t.decimal "price", null: false
      t.timestamps
      t.index ["product_id"], name: "index_product_variants_on_product_id"
      t.index ["color_id"], name: "index_product_variants_on_color_id"
      t.index ["size_id"], name: "index_product_variants_on_size_id"
    end
  end
end
