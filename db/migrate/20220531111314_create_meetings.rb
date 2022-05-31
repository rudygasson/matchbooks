class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.date :date
      t.time :time
      t.references :location, null: false, foreign_key: true
      t.enum :status, enum_type: :integer, default: :pending

      t.timestamps
    end
  end
end
