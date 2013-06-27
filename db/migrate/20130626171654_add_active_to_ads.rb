class AddActiveToAds < ActiveRecord::Migration
  def change
    add_column :ads, :active, :boolean
  end
end
