class Representative < ApplicationRecord
  belongs_to :district
  has_many :campaign_representatives
  has_many :campaigns, through: :campaign_representatives
end
