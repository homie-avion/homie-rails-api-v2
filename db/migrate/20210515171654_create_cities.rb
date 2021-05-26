class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.decimal :latitude, precision: 10, scale: 6, null: true
      t.decimal :longitude, precision: 10, scale: 6, null: true

      t.timestamps
    end
  end
end
