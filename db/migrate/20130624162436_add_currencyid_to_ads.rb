class AddCurrencyidToAds < ActiveRecord::Migration
  def change
    add_column :ads, :currency_id, :integer
  end
end
