class AddFieldBalanceDueToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :balance_amount, :decimal, precision: 10, scale: 2
  end
end
