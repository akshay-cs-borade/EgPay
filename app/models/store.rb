# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  address    :text
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Store < ApplicationRecord
    has_many :users
    has_many :customers
    has_many :products
    has_many :invoices
    has_many :payments
end
