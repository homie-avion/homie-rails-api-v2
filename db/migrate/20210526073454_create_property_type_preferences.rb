class CreatePropertyTypePreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :property_type_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property_type, null: false, foreign_key: true

      t.timestamps
    end

    add_index :property_type_preferences, [:user_id, :property_type_id], unique: true
  end
end
