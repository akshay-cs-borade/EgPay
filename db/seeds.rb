require 'faker'

# Create Roles
super_admin_role = Role.find_or_create_by!(name: 'super_admin')
admin_role = Role.find_or_create_by!(name: 'admin')
store_manager_role = Role.find_or_create_by!(name: 'store_manager')

# Create Store
store = Store.find_or_create_by!(
  name: 'Renuka Mens Wear Testing',
  address: '67 Renuka Nagar',
  phone: "+91 #{Faker::Number.number(digits: 10)}", # Indian phone number
  email: 'aborade-test@eg.com'
)

# Create Users for the store
super_admin = User.find_or_create_by!(email: 'aborade-test+1@eg.com') do |user|
  user.password = 'password'
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.store = store
end
UserRole.find_or_create_by!(user: super_admin, role: super_admin_role)

admin = User.find_or_create_by!(email: 'aborade-test+2@eg.com') do |user|
  user.password = 'password'
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.store = store
end
UserRole.find_or_create_by!(user: admin, role: admin_role)

store_manager = User.find_or_create_by!(email: 'aborade-test+3@eg.com') do |user|
  user.password = 'password'
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.store = store
end
UserRole.find_or_create_by!(user: store_manager, role: store_manager_role)

# Create Sizes
sizes = ['M', 'L', 'XL', 'XXL'].map do |size|
  Size.find_or_create_by!(name: size)
end

# Create Colors
colors = 5.times.map do
  Color.find_or_create_by!(name: Faker::Color.color_name)
end

# Create Customers and their Invoices
10.times do
  customer = Customer.find_or_create_by!(email: Faker::Internet.email) do |cust|
    cust.name = Faker::Name.name
    cust.phone = Faker::Number.number(digits: 10) # Indian phone number
    cust.address = Faker::Address.street_address
    cust.store = store
  end

  # Create Invoices for each customer
  5.times do
    invoice = Invoice.create!(
      invoice_number: Faker::Number.unique.number(digits: 10).to_s,
      customer: customer,
      issue_date: Faker::Date.backward(days: 30),
      due_date: Faker::Date.forward(days: 30),
      status: ['pending', 'paid', 'overdue'].sample,
      total_amount: Faker::Commerce.price(range: 100.0..1000.0),
      store: store
    )

    # Create Products and their Variants for each store
    5.times do
      product = Product.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        price: Faker::Commerce.price(range: 10.0..100.0),
        quantity_available: Faker::Number.between(from: 1, to: 100),
        user: store_manager,
        store: store
      )

      barcode = Barcode.create!(
        barcode_number: Faker::Number.unique.number(digits: 13).to_s,
        product: product,
        store: store
      )
      product.update(barcode_id: barcode.id)

      # Create Product Variants for each product
      3.times do
        color = colors.sample
        size = sizes.sample

        variant = ProductVariant.find_or_create_by!(
          product: product,
          color: color,
          size: size,
          price: Faker::Commerce.price(range: 10.0..100.0)
        )

        # Create Invoice Items for each invoice
        InvoiceItem.create!(
          invoice: invoice,
          product_variant: variant,
          quantity: Faker::Number.between(from: 1, to: 5),
          unit_price: variant.price,
          line_total: variant.price * Faker::Number.between(from: 1, to: 5)
        )
      end
    end

    # Create Payments for each invoice
    Payment.create!(
      payment_date: Faker::Date.backward(days: 15),
      amount: invoice.total_amount,
      payment_method: ['credit_card', 'cash', 'bank_transfer'].sample,
      transaction_id: Faker::Number.unique.number(digits: 10).to_s,
      invoice: invoice,
      store: store
    )
  end
end

puts "Seed data created successfully!"
