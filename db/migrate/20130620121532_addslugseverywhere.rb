class Addslugseverywhere < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug, unique: true

    add_column :states, :slug, :string
    add_index :states, :slug, unique: true

    add_column :cities, :slug, :string
    add_index :cities, :slug, unique: true

  end
end
