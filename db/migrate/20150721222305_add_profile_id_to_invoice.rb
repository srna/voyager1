class AddProfileIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :profile_id, :integer
  end
end
