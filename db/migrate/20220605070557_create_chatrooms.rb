class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.references :meeting, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
