# == Schema Information
#
# Table name: barcodes
#
#  id             :integer          not null, primary key
#  barcode_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#
# Indexes
#
#  index_barcodes_on_product_id  (product_id)
#
# Foreign Keys
#
#  product_id  (product_id => products.id)
#
class Barcode < ApplicationRecord
    belongs_to :product
end
