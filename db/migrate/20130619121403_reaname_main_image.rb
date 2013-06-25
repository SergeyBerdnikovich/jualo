class ReanameMainImage < ActiveRecord::Migration
  def change
  	rename_column :ads, :main_image_id, :image_id
  end
end
