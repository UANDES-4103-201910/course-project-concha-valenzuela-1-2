class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :password_confirmation
      t.date :birthdate
      t.string :city
      t.string :provider
      t.string :uid
      t.string :country
      t.string :gps
      t.text :biography
      t.boolean :status, :default => true
      t.boolean :terms
      t.boolean :aup
      t.boolean :adm, :default => false
      t.boolean :super_adm, :default => false

      t.timestamps
    end
  end
end
