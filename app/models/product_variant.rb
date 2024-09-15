# == Schema Information
#
# Table name: product_variants
#
#  id         :integer          not null, primary key
#  price      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color_id   :integer          not null
#  product_id :integer          not null
#  size_id    :integer          not null
#
# Indexes
#
#  index_product_variants_on_color_id    (color_id)
#  index_product_variants_on_product_id  (product_id)
#  index_product_variants_on_size_id     (size_id)
#
class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :color
  belongs_to :size
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :color_id, :size_id, :price, presence: true
end
