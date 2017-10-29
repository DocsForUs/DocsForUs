class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :specialty, null: false
      t.string :gender
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode, null: false
      t.string :phone_number
      t.string :website
      t.string :email_address

      t.timestamps
    end
  end
end
