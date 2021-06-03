class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.string :name
      t.decimal :min, null: true
      t.decimal :max, null: true
      
      t.timestamps
    end
  end
end
