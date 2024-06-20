class AddStoreReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :store, foreign_key: true
    add_reference :customers, :store, foreign_key: true
    add_reference :products, :store, foreign_key: true
    add_reference :invoices, :store, foreign_key: true
    add_reference :payments, :store, foreign_key: true
  end
end
