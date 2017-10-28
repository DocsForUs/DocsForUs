class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.belongs_to :user
      t.belongs_to :doctor
      t.text :review
      t.timestamps
    end
  end
end
