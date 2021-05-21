class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email

      t.references :role
      
      t.string :first_name, null: true
      t.string :last_name, null: true

      t.string :property_type_preference, null: true
      t.integer :rent_price_preference, null: true
      t.integer :length_of_stay_preference, null: true

      t.integer :city_preference, array: true

      t.timestamps
    end
  end
end
