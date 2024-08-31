class HomesController < ApplicationController
  layout "admin"

  def index
    if current_user.admin? || current_user.store_manager?
      redirect_to invoices_path
    end  
  end  
end
