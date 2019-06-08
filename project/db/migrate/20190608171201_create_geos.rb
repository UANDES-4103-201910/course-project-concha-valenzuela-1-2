class CreateGeos < ActiveRecord::Migration[5.2]
  def change
    create_table :geos do |t|
      t.string :name
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
