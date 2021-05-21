class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.integer :rent_price
      t.integer :length_of_stay
      t.integer :tenant_count
      t.string :address
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :like_count
      t.integer :watch_list_count
      t.integer :homie_value
      t.integer :cost_living_index
      t.integer :flood_index
      t.string :status

      t.timestamps
      
    end
  end
end
