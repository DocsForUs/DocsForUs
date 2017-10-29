class CreateRecommendationsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :recommendations, :tags
  end
end
