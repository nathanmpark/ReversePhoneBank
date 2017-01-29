class CreateReps < ActiveRecord::Migration[5.0]
  def change
    create_table :reps do |t|
      t.string :party
      t.string :name
      t.string :email
      t.string :img_url
      t.references :address, foreign_key: true
      t.references :office, foreign_key: true
      t.timestamps
    end
  end
end
