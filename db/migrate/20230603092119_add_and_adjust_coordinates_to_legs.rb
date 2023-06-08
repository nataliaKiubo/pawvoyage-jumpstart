class AddAndAdjustCoordinatesToLegs < ActiveRecord::Migration[7.0]
  def change
    rename_column :legs, :latitude, :origin_latitude
    rename_column :legs, :longitude, :origin_longitude

    add_column :legs, :destination_latitude, :float
    add_column :legs, :destination_longitude, :float
  end
end
