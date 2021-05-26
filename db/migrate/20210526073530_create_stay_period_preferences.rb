class CreateStayPeriodPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :stay_period_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stay_period, null: false, foreign_key: true

      t.timestamps
    end

    add_index :stay_period_preferences, [:user_id, :stay_period_id], unique: true
  end
end
