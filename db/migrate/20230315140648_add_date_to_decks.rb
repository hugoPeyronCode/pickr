class AddDateToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :date, :datetime
  end
end
