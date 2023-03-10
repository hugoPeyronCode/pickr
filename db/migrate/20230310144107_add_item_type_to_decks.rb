class AddItemTypeToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :item_type, :string
  end
end
