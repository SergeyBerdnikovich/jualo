class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :ad_id
      t.string :name
      t.text :description
      t.string :address

      t.timestamps
    end
  end
end
