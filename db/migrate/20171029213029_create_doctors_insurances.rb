class CreateDoctorsInsurances < ActiveRecord::Migration[5.1]
  def change
    create_join_table :insurances, :doctors
  end
end
