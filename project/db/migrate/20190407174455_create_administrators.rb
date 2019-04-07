class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :geofence

      t.timestamps
    end
  end
end
