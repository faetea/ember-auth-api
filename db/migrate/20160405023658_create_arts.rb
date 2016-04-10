class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.string :title
      t.text :caption
      t.string :image

      t.references :collection, null: false
      t.timestamps null: false
    end
  end
end
