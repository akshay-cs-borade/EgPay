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
require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
