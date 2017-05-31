class CreateCampaignReps < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_reps do |t|
      t.references :campaign
      t.references :rep
      t.timestamps
    end
  end
end
