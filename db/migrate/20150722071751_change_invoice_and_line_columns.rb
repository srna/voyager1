class ChangeInvoiceAndLineColumns < ActiveRecord::Migration
  def up
    change_column :invoices, :issue_date, :date
    add_column :invoices, :due_date, :date
    add_index :invoices, :ba_id

    remove_column :lines, :ba_id
  end
  def down
    change_column :invoices, :issue_date, :datetime
    remove_column :invoices, :due_date
    remove_index :invoices, :ba_id

    add_column :lines, :ba_id, :integer
  end
end
