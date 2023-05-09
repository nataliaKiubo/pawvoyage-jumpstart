class Leg < ApplicationRecord
  belongs_to :vehicle
  belongs_to :trip
  belongs_to :origin_address, class_name: 'Address', foreign_key: 'origin_id'
  belongs_to :destination_address, class_name: 'Address', foreign_key: 'destination_id'
end
