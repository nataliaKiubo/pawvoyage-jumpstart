class CreateLegs < ActiveRecord::Migration[7.0]
  def change
    create_table :legs do |t|
      t.text :description
      t.string :provider
      t.references :vehicle, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true
      t.integer :origin_id
      t.integer :destination_id

      t.timestamps
    end
  end
end
