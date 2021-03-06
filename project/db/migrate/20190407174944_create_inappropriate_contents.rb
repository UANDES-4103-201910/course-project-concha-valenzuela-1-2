class CreateInappropriateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :inappropriate_contents do |t|
      t.text :description
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
