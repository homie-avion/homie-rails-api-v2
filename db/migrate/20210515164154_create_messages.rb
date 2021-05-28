class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat
      t.references :user_id
      t.timestamps
    end
  end
end
