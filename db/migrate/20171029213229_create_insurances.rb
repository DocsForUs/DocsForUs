class CreateInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :insurances do |t|
      t.string :insurance_uid
      t.string :insurance_name
      t.timestamps
    end
  end
end
