class Address < ApplicationRecord
  has_many :users
  has_many :district_addresses
  has_many :districts, through: :district_addresses
end
