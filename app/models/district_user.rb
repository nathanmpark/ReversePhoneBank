class DistrictUser < ApplicationRecord
  belongs_to :district
  belongs_to :user
end
