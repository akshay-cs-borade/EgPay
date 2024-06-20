json.extract! payment, :id, :payment_date, :amount, :payment_method, :transaction_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
