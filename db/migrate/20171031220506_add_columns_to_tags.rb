class AddColumnsToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :default, :boolean, null: false
    add_column :tags, :category, :string, null: false
  end
end
