class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      
      t.string :first_name
      t.string :last_name

      t.string :property_type_preference
      t.integer :rent_price_preference
      t.integer :length_of_stay_preference

      t.integer :city_preference, array: true

      t.timestamps
    end
  end
end
