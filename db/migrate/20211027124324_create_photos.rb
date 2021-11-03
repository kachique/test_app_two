class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :url
      t.string :description
      t.string :license
      t.string :integer
      t.integer :visibility

      t.timestamps
    end
  end
end
