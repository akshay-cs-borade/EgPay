module InvoicesHelper
  def invoice_number
    "#{current_user.short_store_name}-#{(DateTime.current.utc.to_f * 1000).to_i}"
  end  
end
