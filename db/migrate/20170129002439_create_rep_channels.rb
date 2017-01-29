class CreateRepChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :rep_channels do |t|
      t.string :channel_type
      t.string :channel_id
      t.references :rep, foreign_key: true
      t.timestamps
    end
  end
end
