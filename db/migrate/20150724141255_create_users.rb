#
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :token, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.string :username, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :avatar

      t.timestamps null: false
    end
  end
end
