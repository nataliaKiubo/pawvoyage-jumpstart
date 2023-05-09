class CreateBreeds < ActiveRecord::Migration[7.0]
  def change
    create_table :breeds do |t|
      t.string :name
      t.boolean :snub_nosed
      t.integer :height
      t.integer :weight
      t.boolean :restricted
      t.string :size
      t.references :pet_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
