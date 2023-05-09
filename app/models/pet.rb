class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :pet_type
end
