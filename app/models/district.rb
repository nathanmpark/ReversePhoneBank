class District < ApplicationRecord

  has_many :district_users
  has_many :users, through: :district_users

  has_many :offices
  has_many :reps, through: :offices, source: :rep

  has_many :campaign_districts
  has_many :campaigns, through: :campaign_districts

end
