class CreateRepUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :rep_urls do |t|
      t.string :url
      t.references :rep, foreign_key: true
      t.timestamps
    end
  end
end
