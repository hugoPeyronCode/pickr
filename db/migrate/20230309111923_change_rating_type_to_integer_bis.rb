class ChangeRatingTypeToIntegerBis < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :rating, :integer
  end
end
