class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.references :customer, null: false, foreign_key: true
      t.date :issue_date
      t.date :due_date
      t.string :status
      t.decimal :total_amount

      t.timestamps
    end
  end
end
