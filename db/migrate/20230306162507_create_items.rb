class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :address
      t.float :rating
      t.integer :price_range
      t.string :type
      t.string :photo_url
      t.string :item_url

      t.timestamps
    end
  end
end
