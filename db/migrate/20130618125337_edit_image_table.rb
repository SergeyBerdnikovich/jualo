class EditImageTable < ActiveRecord::Migration
  def change
    add_attachment :images, :image
    add_column :images, :url, :string
    add_column :images, :need_download, :boolean, :default => 0
  end
end
