class AddColumnToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :address, :string
    add_column :decks, :rating, :integer
    add_column :decks, :price_range, :integer
  end
end
