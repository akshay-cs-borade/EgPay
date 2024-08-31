# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  address    :text
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#
# Indexes
#
#  index_customers_on_store_id  (store_id)
#
# Foreign Keys
#
#  store_id  (store_id => stores.id)
#
class Customer < ApplicationRecord
  attr_accessor :name_with_phone
  self.per_page = 5

  belongs_to :store
  has_many :invoices

  validates :name, :phone, presence: true

  def name_with_phone
    "#{phone}, #{name}"
  end  
end
