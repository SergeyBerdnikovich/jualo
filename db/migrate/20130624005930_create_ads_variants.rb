class CreateAdsVariants < ActiveRecord::Migration
  def change
    create_table :ads_variants do |t|
      t.integer :ad_id
      t.integer :variant_id

      t.timestamps
    end
  end
end
