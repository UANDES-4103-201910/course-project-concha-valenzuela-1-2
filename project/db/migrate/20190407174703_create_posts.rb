class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :country
      t.string :gps
      t.attachment :file
      t.boolean :close
      t.boolean :unresolved, :default => true
      t.boolean :inappropriate, :default => false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
