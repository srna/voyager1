class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :agenda, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps null: false
    end
  end
end
