class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :division_id
      t.references :district, foreign_key: true
      t.timestamps
    end
  end
end
