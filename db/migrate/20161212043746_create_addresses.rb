class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.integer :primary_zip
      t.integer :extended_zip

      t.timestamps
    end
  end
end
