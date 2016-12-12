class DistrictAddress < ApplicationRecord
  belongs_to :district
  belongs_to :address
end
