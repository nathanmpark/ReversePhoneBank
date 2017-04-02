class Campaign < ApplicationRecord

  has_many :campaign_districts
  has_many :districts, through: :campaign_districts

  has_many :campaign_users
  has_many :users, through: :campaign_users

  has_many :campaign_reps
  has_many :reps, through: :campaign_reps

  has_many :campaign_tags
  has_many :tags, through: :campaign_tags

  belongs_to :owner, class_name: :User

end
