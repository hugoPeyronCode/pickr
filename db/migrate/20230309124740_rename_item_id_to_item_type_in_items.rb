class RenameItemIdToItemTypeInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :item_id, :item_type
  end
end
