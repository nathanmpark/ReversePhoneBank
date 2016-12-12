class CreateDistrictAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :district_addresses do |t|
      t.references :district, foreign_key: true
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
