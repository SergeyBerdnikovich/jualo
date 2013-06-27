class CreateAttachTokens < ActiveRecord::Migration
  def change
    create_table :attach_tokens do |t|
      t.string :token
      t.integer :ad_id

      t.timestamps
    end
  end
end
