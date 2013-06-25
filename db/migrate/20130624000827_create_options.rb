class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :category_id
      t.string :name

      t.timestamps
    end
  end
end
