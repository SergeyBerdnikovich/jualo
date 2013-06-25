class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :ads, :category_id
    add_index :ads, :ad_type_id
    add_index :ads, :ad_condition_id
    add_index :ads, :price
    add_index :ads, :city_id
    add_index :ads, :state_id
    add_index :ads, :user_id
    add_index :ads, :created_at

    add_index :categories, :parent

    add_index :images, :ad_id
    

  end
end
