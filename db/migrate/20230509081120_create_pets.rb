class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :pet_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
