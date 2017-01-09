class User < ApplicationRecord
  belongs_to :address
  has_many :campaign_users
  has_many :campaigns, through: :campaign_users
end
