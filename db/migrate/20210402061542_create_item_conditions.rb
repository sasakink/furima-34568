class CreateItemConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :item_conditions do |t|

      t.timestamps
    end
  end
end
