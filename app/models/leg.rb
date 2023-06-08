class Leg < ApplicationRecord
  before_save :geocode_endpoints

  belongs_to :vehicle
  belongs_to :trip

  geocoded_by :origin do |obj, results|
    if (geo = results.first)
      obj.origin_latitude = geo.latitude
      obj.origin_longitude = geo.longitude
    end
  end

  geocoded_by :destination do |obj, results|
    if (geo = results.first)
      obj.destination_latitude = geo.latitude
      obj.destination_longitude = geo.longitude
    end
  end

  after_validation :geocode_origin, if: :will_save_change_to_origin?
  after_validation :geocode_destination, if: :will_save_change_to_destination?

  def markers
    [
      {
        lat: self.origin_latitude,
        lng: self.origin_longitude
      },
      {
        lat: self.destination_latitude,
        lng: self.destination_longitude
      }
    ]
  end

  private

  def geocode_endpoints
    if origin_changed?
      geocoded = Geocoder.search(origin).first
      if geocoded
        self.origin_latitude = geocoded.latitude
        self.origin_longitude = geocoded.longitude
      end
    end
    # Repeat for destination
    if destination_changed?
      geocoded = Geocoder.search(destination).first
      if geocoded
        self.destination_latitude = geocoded.latitude
        self.destination_longitude = geocoded.longitude
      end
    end
  end

  def geocode_origin
    geocode if origin.present? && (origin_latitude.blank? || origin_longitude.blank?)
  end

  def geocode_destination
    geocode if destination.present? && (destination_latitude.blank? || destination_longitude.blank?)
  end



  # belongs_to :origin_address, class_name: 'Address', foreign_key: 'origin_id'
  # belongs_to :destination_address, class_name: 'Address', foreign_key: 'destination_id'
end
