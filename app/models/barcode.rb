# == Schema Information
#
# Table name: barcodes
#
#  id             :integer          not null, primary key
#  barcode_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#  store_id       :integer
#
# Indexes
#
#  index_barcodes_on_product_id  (product_id)
#  index_barcodes_on_store_id    (store_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#  store_id    (store_id => stores.id)
#
class Barcode < ApplicationRecord
    belongs_to :product
    belongs_to :store
end
