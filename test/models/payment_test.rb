# == Schema Information
#
# Table name: payments
#
#  id             :integer          not null, primary key
#  amount         :decimal(, )
#  payment_date   :date
#  payment_method :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invoice_id     :integer          not null
#  store_id       :integer
#  transaction_id :string
#
# Indexes
#
#  index_payments_on_invoice_id  (invoice_id)
#  index_payments_on_store_id    (store_id)
#
# Foreign Keys
#
#  invoice_id  (invoice_id => invoices.id)
#  store_id    (store_id => stores.id)
#
require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
