class District < ApplicationRecord
  belongs_to :campaign
  has_many :representatives
  has_many :district_addresses
  has_many :districts, through: :district_addresses
end
