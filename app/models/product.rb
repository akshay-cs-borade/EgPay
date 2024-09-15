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
    has_many :product_variants, dependent: :destroy
    has_many :colors, through: :product_variants
    has_many :sizes, through: :product_variants

    accepts_nested_attributes_for :product_variants, allow_destroy: true

    def name_with_barcode
      "#{name} #{barcode.barcode_number}"
    end

    def generate_barcode(size, type)
      # Get the current time in UTC as a unique integer
      timestamp = Time.now.utc.strftime("%H%M%S%L")
      
      # Construct the barcode
      barcode = "RMW-#{timestamp}#{id}-#{size.upcase}-#{type}"
    end  
end
