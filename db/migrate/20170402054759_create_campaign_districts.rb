class CreateCampaignDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_districts do |t|
      t.references :campaign
      t.references :district
      t.timestamps
    end
  end
end
