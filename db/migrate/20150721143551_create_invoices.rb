class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :ba_id
      t.integer :number
      t.datetime :issue_date
      t.string :client_name

      t.timestamps null: false
    end
  end
end
