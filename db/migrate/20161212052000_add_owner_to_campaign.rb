class AddOwnerToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :owner_id, :integer
  end
end
