class CreateHandovers < ActiveRecord::Migration[7.0]
  def change
    create_table :handovers do |t|
      t.references :meeting, null: false, foreign_key: true
      t.references :copy, null: false, foreign_key: true
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :deliverer, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false
      t.timestamp :confirmed

      t.timestamps
    end
  end
end
