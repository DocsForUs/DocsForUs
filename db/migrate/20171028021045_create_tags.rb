class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :description, null: false, unique: true
      t.timestamps
    end
  end
end
