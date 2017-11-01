class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.boolean :admin, default: false
      t.boolean :superadmin, default: false
      t.timestamps
    end
  end
end
