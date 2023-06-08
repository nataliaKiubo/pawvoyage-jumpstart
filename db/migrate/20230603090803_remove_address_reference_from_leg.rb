class RemoveAddressReferenceFromLeg < ActiveRecord::Migration[7.0]
  def change
    rename_column :legs, :origin_id, :origin
    change_column :legs, :origin, :string

    rename_column :legs, :destination_id, :destination
    change_column :legs, :destination, :string
  end
end
