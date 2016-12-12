class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :address, foreign_key: true
      t.integer :user_type

      t.timestamps
    end
  end
end
