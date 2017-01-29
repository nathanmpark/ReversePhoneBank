class DeleteDistrictAddresses < ActiveRecord::Migration[5.0]
  def change
    drop_table :district_addresses
  end
end
