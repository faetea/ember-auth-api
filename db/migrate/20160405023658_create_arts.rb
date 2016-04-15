class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.string :title
      t.text :caption

      t.references :collection, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
