class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.datetime :birth_date
      t.string :email
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.integer :postal_code

      t.timestamps
    end
  end
end
