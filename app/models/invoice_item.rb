# == Schema Information
#
# Table name: invoice_items
#
#  id         :integer          not null, primary key
#  line_total :decimal(, )
#  quantity   :integer
#  unit_price :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invoice_id :integer          not null
#  product_id :integer          not null
#
# Indexes
#
#  index_invoice_items_on_invoice_id  (invoice_id)
#  index_invoice_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  invoice_id  (invoice_id => invoices.id)
#  product_id  (product_id => products.id)
#
class InvoiceItem < ApplicationRecord
    belongs_to :invoice
    belongs_to :product
end