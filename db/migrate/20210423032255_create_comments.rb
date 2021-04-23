class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :item_id, null: false
      t.text :text,       null: false
      t.timestamps
    end
  end
end
