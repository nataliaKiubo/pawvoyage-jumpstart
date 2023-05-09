class Address < ApplicationRecord
  # WE HAVE TO CHECK IF THIS IS THE RIGHT PLACE
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
  has_many :legs
end
