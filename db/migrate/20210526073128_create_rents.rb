class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.string :name
      t.integer :minimum
      t.integer :maximum
      
      t.timestamps
    end
  end
end
