class Trip < ApplicationRecord
  belongs_to :user
  has_many :legs
end
