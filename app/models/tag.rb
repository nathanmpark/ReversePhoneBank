class Tag < ApplicationRecord
  has_many :campaign_tags
  has_many :campaigns, through: :campaign_tags
end
