class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      
      t.integer :rent_price

      t.integer :tenant_count
      t.integer :property_count

      t.string :bldg_no, null: true
      t.string :street, null: true
      t.string :barangay, null: true
      t.text :complete_address, null: true

      t.text :picture_urls, array: true, default: []

      t.decimal :latitude, precision: 10, scale: 6, null: true
      t.decimal :longitude, precision: 10, scale: 6, null: true

      t.integer :like_count, default: 0
      t.integer :watch_list_count, default: 0

      t.integer :homie_value, default: 5
      t.integer :cost_living_index, default: 5
      t.integer :flood_index, default: 5

      t.boolean :posted, default: false

      t.references :user
      t.references :city
      t.references :rent
      t.references :stay_period
      t.references :property_type

      t.timestamps
    end
  end
end
