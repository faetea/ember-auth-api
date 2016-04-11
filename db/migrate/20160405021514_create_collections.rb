class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.text :desc
      t.string :cover

      t.references :user, null: false
      t.timestamps null: false
    end
  end
end
