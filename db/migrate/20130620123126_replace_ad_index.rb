class ReplaceAdIndex < ActiveRecord::Migration
  def change
  	  remove_index :ads, :slug
  	  add_index :ads, [:slug, :city_id,:state_id, :category_id], :unique=>true

  end
end
