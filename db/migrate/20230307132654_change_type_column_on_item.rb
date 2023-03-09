class ChangeTypeColumnOnItem < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :type, :integer
  end
end
