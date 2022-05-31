class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.text :description
      t.integer :year
      t.string :thumbnail
      t.string :cover_image

      t.timestamps
    end
  end
end
