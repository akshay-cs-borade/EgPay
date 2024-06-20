# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  store_id               :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_store_id              (store_id)
#
# Foreign Keys
#
#  store_id  (store_id => stores.id)
#
class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar
  belongs_to :store
  has_many :customers
  has_many :products
  has_many :user_roles
  has_many :invoices, through: :customers
  has_many :roles, through: :user_roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
