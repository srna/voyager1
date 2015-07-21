class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :ba_id
      t.string :description
      t.integer :quantity
      t.float :unit_price
      t.float :cost

      t.timestamps null: false
    end
  end
end
