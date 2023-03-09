class AddFieldsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :movie_title, :string
    add_column :items, :movie_director, :string
    add_column :items, :synopsis, :text
    add_column :items, :movie_genre, :string
  end
end
