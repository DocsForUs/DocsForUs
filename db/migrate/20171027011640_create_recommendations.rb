class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.text :review
      # t.references :user, foreign_key: true
      # t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
