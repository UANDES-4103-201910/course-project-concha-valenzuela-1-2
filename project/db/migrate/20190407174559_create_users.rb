class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.date :birthdate
      t.string :city
      t.string :country
      t.string :gps
      t.text :biography
      t.string :picture
      t.boolean :active, :default => true
      t.boolean :terms

      t.timestamps
    end
  end
end
