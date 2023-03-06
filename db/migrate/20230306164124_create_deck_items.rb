class CreateDeckItems < ActiveRecord::Migration[7.0]
  def change
    create_table :deck_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
