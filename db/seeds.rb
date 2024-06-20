# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'


# Create Roles
super_admin_role = Role.create(name: 'super_admin')
admin_role = Role.create(name: 'admin')
store_manager_role = Role.create(name: 'store_manager')

# Create Stores
3.times do
  store = Store.create(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email
  )

  # Create Users for each store
  super_admin = User.create(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    store: store
  )
  UserRole.create(user: super_admin, role: super_admin_role)

  admin = User.create(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    store: store
  )
  UserRole.create(user: admin, role: admin_role)

  store_manager = User.create(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    store: store
  )
  UserRole.create(user: store_manager, role: store_manager_role)

  # Create Customers for each store
  10.times do
    customer = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      address: Faker::Address.street_address,
      store: store
    )

    # Create Invoices for each customer
    5.times do
      invoice = Invoice.create(
        invoice_number: Faker::Number.unique.number(digits: 10).to_s,
        customer: customer,
        issue_date: Faker::Date.backward(days: 30),
        due_date: Faker::Date.forward(days: 30),
        status: ['pending', 'paid', 'overdue'].sample,
        total_amount: Faker::Commerce.price(range: 100.0..1000.0),
        store: store
      )

      # Create Products for each store
      5.times do
        product = Product.create(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.sentence,
          price: Faker::Commerce.price(range: 10.0..100.0),
          quantity_available: Faker::Number.between(from: 1, to: 100),
          user: store_manager,
          store: store
        )

        barcode = Barcode.create(
          barcode_number: Faker::Number.unique.number(digits: 13).to_s,
          product: product
        )

        product.update(barcode_id: barcode.id)

        # Create Invoice Items for each invoice
        InvoiceItem.create(
          invoice: invoice,
          product: product,
          quantity: Faker::Number.between(from: 1, to: 5),
          unit_price: product.price,
          line_total: product.price * Faker::Number.between(from: 1, to: 5)
        )
      end

      # Create Payments for each invoice
      Payment.create(
        invoice: invoice,
        payment_date: Faker::Date.backward(days: 15),
        amount: invoice.total_amount,
        payment_method: ['credit_card', 'cash', 'bank_transfer'].sample,
        transaction_id: Faker::Number.unique.number(digits: 10).to_s,
        store: store
      )
    end
  end
end

puts "Seed data created successfully!"