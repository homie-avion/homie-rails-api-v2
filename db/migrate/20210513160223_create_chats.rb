class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|

      t.boolean :success

      t.timestamps
    end
  end
end
