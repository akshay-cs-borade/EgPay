class CreateBarcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :barcodes do |t|
      t.string :barcode_number
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
