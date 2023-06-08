class Trip < ApplicationRecord
  belongs_to :user
  has_many :legs
  accepts_nested_attributes_for :legs, allow_destroy: true
end
