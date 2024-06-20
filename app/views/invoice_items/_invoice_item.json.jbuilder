json.extract! invoice_item, :id, :quantity, :unit_price, :line_total, :created_at, :updated_at
json.url invoice_item_url(invoice_item, format: :json)
