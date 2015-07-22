class AddTotalAmountToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :total_amount, :float
  end
end
