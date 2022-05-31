class CreateCopies < ActiveRecord::Migration[7.0]
  def change
    create_table :copies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
