class RenameIntegerToItemIdInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :integer, :item_id
  end
end
