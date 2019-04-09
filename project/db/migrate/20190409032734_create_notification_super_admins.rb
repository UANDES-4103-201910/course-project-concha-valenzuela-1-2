class CreateNotificationSuperAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_super_admins do |t|
      t.references :post, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
