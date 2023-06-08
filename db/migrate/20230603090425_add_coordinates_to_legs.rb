class AddCoordinatesToLegs < ActiveRecord::Migration[7.0]
  def change
    add_column :legs, :latitude, :float
    add_column :legs, :longitude, :float
  end
end
