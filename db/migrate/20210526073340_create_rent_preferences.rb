class CreateRentPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :rent_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :rent, null: false, foreign_key: true

      t.timestamps
    end

    add_index :rent_preferences, [:user_id, :rent_id], unique: true
  end
end
