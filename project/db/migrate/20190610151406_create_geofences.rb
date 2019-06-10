class CreateGeofences < ActiveRecord::Migration[5.2]
  def change
    create_table :geofences do |t|

      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
