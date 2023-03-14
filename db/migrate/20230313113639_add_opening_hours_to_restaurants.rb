class AddOpeningHoursToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :opening_hours, :string, array: true
  end
end
