class CreateRepPhoneNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :rep_phone_numbers do |t|
      t.string :number
      t.references :rep, foreign_key: true
      t.timestamps
    end
  end
end
