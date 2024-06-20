# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  description        :text
#  name               :string
#  price              :decimal(, )
#  quantity_available :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  barcode_id         :integer
#  store_id           :integer
#  user_id            :integer          not null
#
# Indexes
#
#  index_products_on_barcode_id  (barcode_id)
#  index_products_on_store_id    (store_id)
#  index_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  barcode_id  (barcode_id => barcodes.id)
#  store_id    (store_id => stores.id)
#  user_id     (user_id => users.id)
#
class Product < ApplicationRecord
    attr_accessor :name_with_barcode

    belongs_to :user
    belongs_to :store
    has_one :barcode
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items

    def name_with_barcode
      "#{name} #{barcode.barcode_number}"
    end
end
