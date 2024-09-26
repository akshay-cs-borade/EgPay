# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  balance_amount :decimal(10, 2)
#  due_date       :date
#  invoice_number :string
#  issue_date     :date
#  status         :string
#  total_amount   :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer          not null
#  store_id       :integer
#
# Indexes
#
#  index_invoices_on_customer_id  (customer_id)
#  index_invoices_on_store_id     (store_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#  store_id     (store_id => stores.id)
#
class Invoice < ApplicationRecord
    self.per_page = 5
    validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
    
    belongs_to :customer
    belongs_to :store
    has_many :invoice_items, dependent: :destroy
    has_many :products, through: :invoice_items
    has_many :payments, dependent: :destroy    
    
    accepts_nested_attributes_for :invoice_items, allow_destroy: true, reject_if: :all_blank
end
