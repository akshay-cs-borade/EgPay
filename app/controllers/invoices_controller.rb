class InvoicesController < ApplicationController
  load_and_authorize_resource
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.joins(:customer).where(store_id: current_user.store_id).page(params[:page])
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReceiptPdf.new(@invoice)
        send_data pdf.render,
                  filename: "receipt_#{@invoice.invoice_number}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
    @customers = Customer.where(store_id: current_user.store_id)
    @products = Product.joins(:barcode).where(store_id: current_user.store_id)
  end

  # GET /invoices/1/edit
  def edit
    @customers = Customer.all
    @products = Product.all
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    respond_to do |format|
      @invoice.store = current_user.store
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        @customers = Customer.all
        @products = Product.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end  
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def invoice_params
    #   params.require(:invoice).permit(:invoice_number, :customer_id, :issue_date, :due_date, :status, :total_amount)
    # end

    def invoice_params
      params.require(:invoice).permit(:customer_id, :issue_date, :due_date, :status, :total_amount, invoice_items_attributes: [:product_id, :quantity, :unit_price, :line_total])
    end
end
