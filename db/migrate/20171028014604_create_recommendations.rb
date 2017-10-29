class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.belongs_to :user, null: false
      t.belongs_to :doctor, null: false
      t.text :review
      t.timestamps
    end
  end
end
