class CreateCityPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :city_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end

    add_index :city_preferences, [:user_id, :city_id], unique: true
  end
end
