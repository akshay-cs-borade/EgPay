desc "Seed Existing Shirts"
task tshirts_xxl: :environment do
    store = Store.find_by(name: 'Renuka Mens Wear')
    size = Size.find_or_create_by!(name: 'XXL')
    store_manager_role_id = Role.find_by(name: 'store_manager').id
    store_manager = store.users.joins(:user_roles).where(user_roles: { role_id: store_manager_role_id }).first

    28.times do |i|
        puts "Creating shirt #{i}"
        product = Product.create(
            name: "TShirt-Full-#{i}",
            description: Faker::Lorem.sentence,
            price: Faker::Commerce.price(range: 10.0..100.0),
            quantity_available: Faker::Number.between(from: 1, to: 5),
            user: store_manager,
            store: store
        )
        puts "Creating ProductVariant #{product.id}"

        pv = ProductVariant.find_or_create_by!(
            product: product,
            color: Color.last,
            size: size,
            price: Faker::Commerce.price(range: 10.0..100.0)
        )
        
        puts "Creating Barcode #{product.id}"
        barcode = Barcode.create!(
            barcode_number: product.generate_barcode(size.name, 'tshirt-full'),
            product: product,
            store: store
        )

        puts "Barcode #{barcode.barcode_number}"
    
        product.update(barcode_id: barcode.id)

        puts "Shirt #{product.id} done"
    end  
end
