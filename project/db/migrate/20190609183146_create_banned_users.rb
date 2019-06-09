class CreateBannedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :banned_users do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
