class AddColumnStoreIdInBarcodes < ActiveRecord::Migration[7.1]
  def change
    add_reference :barcodes, :store, foreign_key: true
  end
end
