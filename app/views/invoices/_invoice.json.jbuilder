json.extract! invoice, :id, :invoice_number, :customer_id, :issue_date, :due_date, :status, :total_amount, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
