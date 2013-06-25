class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :option_id
      t.string :value

      t.timestamps
    end
  end
end
