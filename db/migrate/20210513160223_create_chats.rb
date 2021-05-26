class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|

      t.boolean :success, default: false

      t.references :user, foreign_key: { to_table: :users }
      t.references :partner, foreign_key: { to_table: :users }
      
      t.references :property
      
      t.timestamps
    end
  end
end
