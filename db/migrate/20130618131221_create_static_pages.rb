class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :name
      t.text :content
      t.integer :locale_id

      t.timestamps
    end
  end
end
