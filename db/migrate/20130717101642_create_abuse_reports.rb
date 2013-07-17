class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.string :name
      t.string :email
      t.text :message
      t.integer :ad_id
      t.string :ip

      t.timestamps
    end
  end
end
