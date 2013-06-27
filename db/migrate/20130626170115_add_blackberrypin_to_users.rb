class AddBlackberrypinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blackberry_pin, :string
  end
end
