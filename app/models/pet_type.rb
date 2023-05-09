class PetType < ApplicationRecord
  has_many :pets
  has_many :breeds
end
