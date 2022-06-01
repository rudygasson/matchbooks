class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.integer :zipcode
      t.string :address
      t.string :name
      t.string :district
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
