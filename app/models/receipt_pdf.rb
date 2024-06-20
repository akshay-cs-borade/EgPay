class ReceiptPdf < Prawn::Document
  require 'prawn/measurement_extensions'
    def initialize(invoice)
      super(page_size: [80.mm, 80.mm], margin: 5)
      @invoice = invoice
      @customer = @invoice.customer
      header
      customer_details
      line_items
      total_price
      footer
    end
  
    def header
      text "Renuka Mens Wear", size: 14, style: :bold, align: :center
      text "Shahu nagar", size: 8, align: :center
      text "Address Line 2", size: 8, align: :center
      text "Phone: 123-456-7890", size: 8, align: :center
      move_down 10
    end
  
    def customer_details
      text "Customer: #{@customer.name}", size: 8
      text "Invoice #: #{@invoice.invoice_number}", size: 8
      move_down 10
    end
  
    def line_items
      text "Items", size: 8, style: :bold
      table(line_item_rows, cell_style: { size: 8, border_width: 0 }) do
        column(0).align = :left
        columns(1..3).align = :right
      end
      move_down 10
    end
  
    def line_item_rows
      [["Description", "Qty", "Price", "Total"]] +
        @invoice.invoice_items.map do |item|
          ['qwqwqwqw', item.quantity, price(item.unit_price), price(10)]
        end
    end
  
    def total_price
      move_down 10
      text "Total: #{price(100)}", size: 10, style: :bold, align: :right
    end
  
    def footer
      move_down 10
      text "Thank you for your business!", size: 8, align: :center
    end
  
    def price(num)
      "$#{'%.2f' % num}"
    end
  end
  