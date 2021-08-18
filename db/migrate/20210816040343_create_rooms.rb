class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :rooms, [:user_id, :created_at]
  end
end
