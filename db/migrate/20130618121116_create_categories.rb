class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent
      t.timestamps
    end
    Category.create(:name=>'Home', :id => 1)
  end
end
