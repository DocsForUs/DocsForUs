class CreateDoctorsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :doctors, :users
  end
end
