class CreateRepresentatives < ActiveRecord::Migration[5.0]
  def change
    create_table :representatives do |t|
      t.references :district, foreign_key: true
      t.integer :rep_type
      t.string :state
      t.string :first_name
      t.string :last_name
      t.integer :party

      t.timestamps
    end
  end
end
