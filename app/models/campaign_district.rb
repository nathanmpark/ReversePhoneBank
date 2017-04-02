class CampaignDistrict < ApplicationRecord
  belongs_to :campaign
  belongs_to :district
end
