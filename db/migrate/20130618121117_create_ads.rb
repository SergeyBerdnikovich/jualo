class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :category_id
      t.integer :ad_type_id
      t.integer :ad_condition_id
      t.float :price
      t.integer :main_image_id
      t.integer :city_id
      t.integer :state_id
      t.integer :user_id

      t.timestamps
    end
  end
end
