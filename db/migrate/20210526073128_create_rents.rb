class CreateRents < ActiveRecord::Migration[6.1]
  def change
    create_table :rents do |t|
      t.string :name
      t.string :filter_expression, null: true
      
      t.timestamps
    end
  end
end
