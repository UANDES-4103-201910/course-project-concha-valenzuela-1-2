class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :country
      t.string :gps
      t.string :file
      t.string :images
      t.datetime :time
      t.boolean :close
      t.boolean :unresolved
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
