class CreateCampaignTags < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_tags do |t|
      t.references :tag, foreign_key: true
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
